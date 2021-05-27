//
//  BaseApiClientConfig.swift
//  IndraMovieApp
//
//  Created by MDP-DESARROLLADOR on 5/23/21.
//

import Foundation

final class BaseApiClientConfig: NSObject {
    var baseUrl: String? = Environment.tunkiBaseUrl
    var path: String?
    var queryItems: [String: String]?
    var headers: [String: String] = [:]
    var httpMethod: String?
    var body: Data?
    var isMockUrl = false
    
    let authorizationHeaderKey = "Authorization"
    let verificationTokenKey = "X-Second-Verification-Id"
    let userHeaderKey = "X-User-Id"
    let clientIdKey = "client_id"
    let accessTokenKey = "access_token"
    let validateEmailHeaderKey = "x-validate-email"
    
    func addAuthorizationHeader(token: String) {
        headers[authorizationHeaderKey] = token
    }
    
    func addVerificationTokenHeader(verificationToken: String) {
        headers[verificationTokenKey] = verificationToken
    }
    
    func addUserIdHeader(userId: String) {
        headers[userHeaderKey] = userId
    }
    
    func addClientIdHeader() {
        headers[clientIdKey] = Environment.tunkiID
    }
    
    func addAccessTokenHeader(accessToken: String) {
        headers[accessTokenKey] = accessToken
    }
    
    func addValidateEmailHeader(validateEmail: Bool = false) {
        headers[validateEmailHeaderKey] = String(validateEmail)
    }
    
    func addQueryItem(key: String, value: String) {
        if queryItems == nil {
            queryItems = [:]
        }
        
        queryItems?[key] = value
    }
}
