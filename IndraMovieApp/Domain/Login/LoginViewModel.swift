//
//  LoginViewModel.swift
//  IndraMovieApp
//
//  Created by Cesar Velasquez on 5/26/21.
//

import UIKit

protocol LoginValidateFieldsOutput: BaseViewModelOutput {
    func showUserAlert(_ alert: String)
    func showPasswordAlert(_ alert: String)
    func enableSendCodeButton(_ enable: Bool)
    func onSuccessLogin()
}

class LoginViewModel {

    var outputValidateFields: LoginValidateFieldsOutput?
    public let maxLengthUser = 9
    public let maxLengthPassword = 6

    init(outputValidationFieldsDelegate: LoginValidateFieldsOutput? = nil) {
        self.outputValidateFields = outputValidationFieldsDelegate
    }
    
    public func validateFields(user: LoginModel.Request) -> Bool {
        if (user.user == emptyString) {
            self.outputValidateFields?.showUserAlert(mandatoryFieldMessage)

            return false
        }
        
        if (user.user != userHarcode ){
            self.outputValidateFields?.showUserAlert(invalidateUser)
            return false
        }
                        
        if (user.password == emptyString) {
            self.outputValidateFields?.showPasswordAlert(mandatoryFieldMessage)

            return false
        }
        
        if user.password != passwordHarcode {
            self.outputValidateFields?.showPasswordAlert(invalidatePass)
            return false
        }
        self.outputValidateFields?.onSuccessLogin()
        return true
    }
    
}
