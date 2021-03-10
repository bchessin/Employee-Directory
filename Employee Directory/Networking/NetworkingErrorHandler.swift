//
//  NetworkingErrorHandler.swift
//  Employee Directory
//
//  Created by Bradford Chessin on 3/10/21.
//

import Foundation

/**
 Four types of errors we handle, with an associated error message
 */
enum NetworkingError: String {
    // The strings map to the localized string key
    case connectionLost = "Connection Lost"
    case generalError = "General Error"
    case noResponse = "No Response"
    case timedOut = "Timed Out"
    
    func localizedString() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

/**
 While not totally necessary, this class provides us the ability to intercept certain networking errors and present graceful messages
 to the end user. In a more abstract case, we can use localizedDescription from the error and present that.
 */
class NetworkingErrorHandler {
    class func handleNetworkingError(_ error: Error?) -> NetworkingError {
        guard let error = error else {
            return .generalError
        }
        
        // Map the error to NSError and grab the necessary data
        let networkError: NSError = error as NSError
        let statusCode = networkError.code
        
        // For the sake of this project let's handle some cases and a generic fallback
        switch statusCode {
        case NSURLErrorTimedOut:
            return .timedOut
        case NSURLErrorNetworkConnectionLost:
            return .connectionLost
        case NSURLErrorCannotConnectToHost:
            return .noResponse
        default:
            return .generalError
        }
    }
}
