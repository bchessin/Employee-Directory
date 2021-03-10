//
//  NetworkingRouter.swift
//  Employee Directory
//
//  Created by Bradford Chessin on 3/10/21.
//

import Foundation


//This class is a router that will point to different endpoints and allow for scalability of more calls in a bigger project
enum PredefinedRoute {
    case getEmployees
    
    var url: String {
        switch self {
        case .getEmployees:
            return "https://s3.amazonaws.com/sq-mobile-interview/employees.json"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getEmployees:
            return .get
        }
    }
}

// This router will take in a predefined route or a dynamic URL (i.e from a JSON).
class NetworkingRouter {
    var url: URL?
    var httpMethod: HTTPMethod?
    
    // Dynamic URLs, if no http method passed assume GET (for now)
    init(url passedURL: URL?, httpMethod passedHTTPMethod: HTTPMethod? = .get) {
        url = passedURL
        httpMethod = passedHTTPMethod
    }
    
    // Predefined (hardcoded) URLs
    init(predefinedRoute: PredefinedRoute) {
        url = URL(string: predefinedRoute.url)
        httpMethod = predefinedRoute.httpMethod
    }
}
