//
//  Conectivity.swift
//  IndraMovieApp
//
//  Created by Cesar Velasquez on 5/26/21.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool? {
        return NetworkReachabilityManager()?.isReachable
    }
}
