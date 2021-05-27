//
//  Conectivity.swift
//  IndraMovieApp
//
//  Created by MDP-DESARROLLADOR on 5/23/21.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool? {
        return NetworkReachabilityManager()?.isReachable
    }
}
