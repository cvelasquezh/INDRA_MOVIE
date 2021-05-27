//
//  ErrorResult.swift
//  IndraMovieApp
//
//  Created by Cesar Velasquez on 5/26/21.
//

import Foundation

class ErrorResult: Error, Codable {
    
    let code: String
    let icon: String?
    var title: String
    var detail: String
    
    public init(code: String,
                icon: String,
                title: String,
                detail: String) {
        
        self.code = code
        self.title = title
        self.detail = detail
        self.icon = icon
    }
    
    static func genericError() -> ErrorResult {
        return .init(code: emptyString,
                     icon: emptyString,
                     title: emptyString,
                     detail: emptyString
        )
    }
}

enum ServiceError: Error {
    case unableToParseResponse
    case defaultError
    case notNetworkConnection
}

struct ErrorResultGeneric: Codable {
    let text: String?
    let code: Int?
}
extension ServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notNetworkConnection:
            return NSLocalizedString("No hay conexión a internet", comment: "Error")
        default:
            return NSLocalizedString("Algo inesperado ocurrió. Estamos trabajando para solucionarlo.", comment: "Error")

        }
    }
}

