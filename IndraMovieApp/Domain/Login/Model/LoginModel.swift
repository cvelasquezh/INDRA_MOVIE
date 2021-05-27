//
//  LoginModel.swift
//  IndraMovieApp
//
//  Created by Cesar Velasquez on 5/26/21.
//

import Foundation

enum LoginModel {

    struct Request {
        let user: String
        let password: String

        init(user: String, password: String) {
            self.user = user
            self.password = password
        }
    }
}
