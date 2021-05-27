//
//  ErrorResultModel.swift
//  IndraMovieApp
//
//  Created by Cesar Velasquez on 5/26/21.
//

import Foundation

class ErrorResultModel {
    
    // Mandatory
    let code: String
    let icon: String
    var title: String
    var detail: ErrorResultDetailModel?
    
    // Optional
    var primaryButton: ErrorResultButtonModel?
    var primaryAction: (() -> Void)?
    
    var secondaryButton: ErrorResultButtonModel?
    var secondaryAction: (() -> Void)?
    

    init(_ error: ErrorResult) {
        code = error.code
        icon = error.icon ?? emptyString
        title = error.title
    }
    
    init(code: String = emptyString,
         title: String,
         icon: String = emptyString,
         message: String = emptyString,
         attributedText: String? = emptyString,
         primaryButtonText: String = "Entendido",
         secondaryButtonText: String? = nil) {
        
        self.code = code
        self.title = title
        self.detail = ErrorResultDetailModel(text: message, attributedText)
        self.icon = icon
        self.primaryButton = ErrorResultButtonModel(text: primaryButtonText)
        
        if let secondaryText = secondaryButtonText {
            self.secondaryButton = ErrorResultButtonModel(text: secondaryText)
        }
    }

    
    func getDescription() -> String {
        return "\(title) \(detail?.text ?? emptyString)"
    }
}

struct ErrorResultDetailModel {
    var text: String
    var attributeText: String?
    

    init(text: String, _ attributedText: String? = emptyString) {
        self.text = text
        self.attributeText = attributedText
    }
}

struct ErrorResultButtonModel {
    var text: String
    let deeplink: String?

    
    init(text: String, _ deeplink: String? = nil) {
        self.text = text
        self.deeplink = deeplink
    }
}


