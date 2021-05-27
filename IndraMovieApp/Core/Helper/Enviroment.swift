//
//  Enviroment.swift
//  IndraMovieApp
//
//  Created by MDP-DESARROLLADOR on 5/23/21.
//

import Foundation

enum EnvironmentType: String {
    case development = "dev"
    case qualityAssurance = "qa"
    case userAcceptanceTesting = "uat"
    case production = "pro"
}

struct Environment {
    
    /// Nombre de la aplicación.
    static var appName: String = Environment.variable(named: "CFBundleName")
    
    /// Identificador de la aplicación.
    static var appIdentifier: String = Environment.variable(named: "CFBundleIdentifier")
    
    /// Numero version de la aplicación.
    static var appVersion: String = Environment.variable(named: "CFBundleShortVersionString")
    
    /// Numero  build de la aplicación.
    static var appBuildVersion: String = Environment.variable(named: "CFBundleVersion")
    
    /// URL base del backend de tunki.
    static var tunkiBaseUrl: String = Environment.variable(named: "TunkiBaseURL")
    
    /// Token ID a usarse en los servicios.
    static var tunkiID: String = Environment.variable(named: "TunkiID")
    
    /// Token Security a usarse en los servicios.
    static var tunkiSecret: String = Environment.variable(named: "TunkiSecret")
    
    /// Scheme del app.
    static var tunkiScheme: String = Environment.variable(named: "TunkiScheme")
    
    /// Scheme Context del app.
    static var tunkiSchemeContext: String = Environment.variable(named: "TunkiSchemeContext")
    
    /// Flag a usarse para bloquear el uso del app en simulador
    static var tunkiDeviceCheck: String = Environment.variable(named: "TunkiDeviceCheck")
    
    /// Bundle Version
    static var tunkiBundleVersion: String = Environment.variable(named: "CFBundleVersion")
    
    // Entorno donde se ejecuta la aplicacion
    static var tunkiEnvironment: String = Environment.variable(named: "TunkiEnvironment")
    
    // Leanplum AppId
    static var leanplumAppId: String = Environment.variable(named: "LeanplumId")
    
    // Leanplum Key
    static var leanplumKey: String = Environment.variable(named: "LeanplumKey")
    
    /// Metodo que permite obtener el valor de un variable del esquema.
    ///
    /// - Parameter name: Nombre de la variable.
    /// - Returns: Valor de la variable.
    static func variable(named name: String) -> String {
        let bundle = Bundle.main
        
        guard let value: String = bundle.infoDictionary?[name] as? String else {
            return emptyString
        }
        
        return value
    }
    
    static func getEnvironmentType() -> EnvironmentType {
        let tunkiEnvironmentString = Environment.tunkiEnvironment
        
        guard let environmentType = EnvironmentType(rawValue: tunkiEnvironmentString) else {
            return EnvironmentType.development
        }
        
        return environmentType
    }

}
