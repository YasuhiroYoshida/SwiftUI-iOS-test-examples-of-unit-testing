//
//  NetworkServiceFactory.swift
//  QuizApp
//
//  Created by Yasuhiro Yoshida on 10/25/21.
//

import Foundation

class NetworkServiceFactory {
    
    static func create() -> NetworkService {
        
        let environment = ProcessInfo.processInfo.environment["ENV"]
        if let environment = environment {
            if environment == "TEST" {
                return Webservice()
            } else {
                return Webservice()
            }
        }
        
        return Webservice()
    }
 
}
