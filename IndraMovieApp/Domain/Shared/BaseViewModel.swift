//
//  BaseViewModel.swift
//  IndraMovieApp
//
//  Created by Cesar Velasquez on 5/26/21.
//

import Foundation

protocol BaseViewModelOutput: class {
    func onValidationError(error: ErrorResultModel)
    func onFailure(error: ErrorResultModel)
    func onForbiddenLogout()
    func onInternetConnectionError()
    func onTimeoutError()
}

class BaseViewModel <INDServiceProtocol, INDOutputDelegate>: NSObject {
    
    weak var outputDelegate: BaseViewModelOutput?
    var service: BaseApiManagerProtocol?
    var callInBackground: Bool = false

    
    func getService() -> INDServiceProtocol? {
        return  service as? INDServiceProtocol
    }
    
    func getOutputDelegate() -> INDOutputDelegate? {
        return  outputDelegate as? INDOutputDelegate
    }
    
    /// Sobreescribir esta función en viewModel que lo implemente para que al realizar el
    /// refresh token pueda volver a llamar a la función una vez actualizado los tokens
    func callService() {
        setValidationError()
        setFailureBlock()
        setErrorGenericBlock()
        setForbiddenBlock()
        setInternetConnectionErrorBlock()
        setTimeoutErrorBlock()
    }
    
    
    //Error 422
    func setValidationError() {
        service?.validationError = { error in
            guard let errorResponse = error as? ErrorResult else {
                return
            }
            
            let errorModel = ErrorResultModel(errorResponse)
            
            if !self.callInBackground {
                self.outputDelegate?.onValidationError(error: errorModel)
            }
            
        }
    }
    
    ///Error generico mostrar a front
    func setFailureBlock() {
        service?.failureBlock = { error in
            //TODO
        }
    }
    
    func setErrorGenericBlock() {
        service?.errorGenericBlock = { error in
            guard let errorDetail = error as? ErrorResultGeneric else {
                return
            }
            
            guard let code = errorDetail.code, code > 0 else {
          
                return
            }
            
        }
    }
    
    func setForbiddenBlock() {
        service?.forbiddenBlock = { [weak self]  in
           // if SessionUserManager.isUserLogged() {
             //   SessionUserManager.logout()
            //}
            self?.outputDelegate?.onForbiddenLogout()
            
            //let errorModel = ErrorResultModel.generic()
        }
    }

    func setTimeoutErrorBlock(){
        service?.timeoutBlock = {
         
        }
    }
    
    func setInternetConnectionErrorBlock() {
        service?.internetConnectionErrorBlock = {
            if !self.callInBackground {
                self.outputDelegate?.onInternetConnectionError()
            }
        }
    }
}

