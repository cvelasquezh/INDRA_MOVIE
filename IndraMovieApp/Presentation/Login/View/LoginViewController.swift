//
//  LoginViewController.swift
//  IndraMovieApp
//
//  Created by Cesar Velasquez on 5/26/21.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var viewModel: LoginViewModel?

    
    @IBOutlet weak var onLogginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel(outputValidationFieldsDelegate: self)
    }
    
    
    @IBAction func onLoginButtonAction(_ sender: Any) {
       _ = viewModel?.validateFields(user: LoginModel.Request(user: userTextField.text ?? emptyString, password: passwordTextField.text ?? emptyString))
    }
    
}

extension LoginViewController: LoginValidateFieldsOutput {
    func showUserAlert(_ alert: String) {
        super.showAlertView(tittle: "Mensaje", message: alert)
        
    }
    
    func showPasswordAlert(_ alert: String) {
        super.showAlertView(tittle: "Mensaje", message: alert)
    }
    
    func enableSendCodeButton(_ enable: Bool) {
        
    }
    
    func onSuccessLogin() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        guard let controller = storyboard.instantiateViewController(identifier: "HomeViewController") as? HomeViewController else {
            return
        }
        controller.barNavigationIsHidden = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
