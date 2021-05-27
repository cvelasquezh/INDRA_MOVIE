//
//  BaseApiManager.swift
//  IndraMovieApp
//
//  Created by Cesar Velasquez on 5/26/21.
//

import Foundation
import Alamofire

protocol BaseApiManagerProtocol {
    var successBlock: ((_ result: Any?) -> Void)? {get set}
    var failureBlock: ((_ error: String) -> Void)? { get set }
    var validationError: ((_ error: Any?) -> Void)? { get set }
    var errorGenericBlock: ((_ error: Any?) -> Void)? { get set }
    var forbiddenBlock: (() -> Void)? { get set }
    var internetConnectionErrorBlock: (() -> Void)? { get set }
    var timeoutBlock: (() -> Void)? { get set }
}

class BaseApiManager<IND, INDError>: NSObject, BaseApiManagerProtocol where IND: Codable, INDError: ErrorResult {
    var successBlock: ((Any?) -> Void)?
    
    var failureBlock: ((String) -> Void)?
    
    var validationError: ((Any?) -> Void)?
    
    var errorGenericBlock: ((Any?) -> Void)?
    
    var forbiddenBlock: (() -> Void)?
    
    var internetConnectionErrorBlock: (() -> Void)?
    
    var timeoutBlock: (() -> Void)?
    
    private let manager: SessionManager
    private var request: URLRequest?
    var config: BaseApiClientConfig

    
    init(manager: SessionManager = SessionManager.default) {
        self.manager = manager
        config = BaseApiClientConfig()
    }
    
    private func createHttpRequest() {
        guard let path = config.path else {
            return
        }
        
        guard let baseUrl = config.baseUrl else {
            return
        }
        
        let urlPathComplete = String(format: "%@%@", baseUrl, path)
        var urlComponents = URLComponents(string: urlPathComplete)
        
        if let queryItems = config.queryItems {
            urlComponents?.queryItems = queryItems.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        if let url = urlComponents?.url {
            request = URLRequest(url: url)
            request?.httpMethod = config.httpMethod
            request?.httpBody = config.body
            request?.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request?.addValue("CUS", forHTTPHeaderField: "x-application")
            request?.addValue("IOS", forHTTPHeaderField: "x-platform")
            request?.addValue(Environment.appVersion, forHTTPHeaderField: "x-app-version")
        }
    }
    
    
    func post() {
        config.httpMethod = HTTPMethod.post.rawValue
        requestData()
    }
    
    func get() {
        config.httpMethod = HTTPMethod.get.rawValue
        requestData()
    }
    
    func put() {
        config.httpMethod = HTTPMethod.put.rawValue
        requestData()
    }
    
    func patch() {
        config.httpMethod = HTTPMethod.patch.rawValue
        requestData()
    }
    
    func delete() {
        config.httpMethod = HTTPMethod.delete.rawValue
        requestData()
    }
    
    func addBody<TRequest> (_ body: TRequest?) where TRequest: Encodable {
        do {
            config.body = try JSONEncoder().encode(body)
        } catch let error {
            failureBlock?(error.localizedDescription)
        }
    }
    
    private func requestData(){
        if let isConnected = Connectivity.isConnectedToInternet(), !isConnected {
            internetConnectionErrorBlock?()
            return
        }

        createHttpRequest()
        
        for header in config.headers {
            request?.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        guard let urlRequest = request else {
            failureBlock?("Could not create UrlRequest")
            return
        }
        
        manager.request(urlRequest)
            .validate()
            .responseData( completionHandler: { [weak self] response in
                
                guard let `self` = self else {
                    return
                }
                
                self.logResponse(with: response.data, response.request?.urlRequest)
                
                //RESPONSE
                switch response.result {
                
                // SUCESS
                case .success:
                    
                    if self.isNoContent(response: response) {
                        self.successBlock?((()-> Void).self)
                        return
                    }
                  //  self.log(response.data)
                    guard let data = response.data,
                        let result = try? JSONDecoder().decode(IND.self, from: data) else {
                    self.failureBlock?(ServiceError.unableToParseResponse.localizedDescription)
                        self.logResponse(with: response.data, ServiceError.unableToParseResponse.localizedDescription)
                            return
                    }
    
                    self.successBlock?(result)
                
                // FAILURE
                case .failure:
                    self.verifyError(response: response)
                    return
                }
            })
    }
    
    private func isNoContent(response: DataResponse<Data>) -> Bool {

        let isNoContent = response.response?.statusCode == 204
        let isEmptyResponse = response.data?.isEmpty ?? false
    
        return isNoContent || isEmptyResponse
    }
    
    fileprivate func logResponse(with data: Data?, _ args: Any?) {
        if let data = data, let responseJson = String(data: data, encoding: .utf8) {
            if let prettyResponseJson = responseJson.data(using: .utf8)?.prettyPrintedJSONString {
               // self.log(args, prettyResponseJson)
            }
        }
    }
    
    private func verifyError(response: DataResponse<Data>) {
        let errorCode = response.response?.statusCode
        
        //timeout
        if errorCode == 504 {
            timeoutBlock?()
            return
        }
        
        //forbiddenBlock
        if errorCode == 401 || errorCode == 403 {
            self.forbiddenBlock?()
            return
        }
        
        //Mensajes de error 422
        if errorCode == 422 {
           // self.validationError?(errorResult)
        } else {
            // Todo error que no sea un 422 será interpretado como error genérico
          //  self.errorGenericBlock?(error)
            
        }
        
        self.logResponse(with: response.data, response.error)
    }
    
}

extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}

