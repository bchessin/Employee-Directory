//
//  EmployeeService.swift
//  Employee Directory
//
//  Created by Bradford Chessin on 3/10/21.
//

import Foundation
import SwiftProtobuf

// Two kinds of result states, success and failure. Success returns list of Employees. Failure provides reason
enum EmployeesServiceResult {
    case empty
    case success([Employee])
    case failure(String)
}

protocol EmployeeServiceProtocol {
    func loadEmployees(completion: @escaping (EmployeesServiceResult) -> ())
}

/**
 This is the layer above Networking that the employee list data models will leverage to get the JSON data from our networking layer.
 We can also extend this class to handle partial JSON errors, use other employee endpoints, etc..
 */
class EmployeeService: EmployeeServiceProtocol {
    private var networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func loadEmployees(completion: @escaping (EmployeesServiceResult) -> ()) {
        // Grab the predefined route and initialize the router instance
        let route = PredefinedRoute.getEmployees
        let router = NetworkingRouter(predefinedRoute: route)
        
        // Start networking request with our networking service
        networking.request(router: router) { result in
            switch result {
            case .success(let data):
                // Use ProtoBuf to parse out the employees
                let response = try? Employees(jsonUTF8Data: data)
                
                // Make sure we got a valid list and that we have no invalid employees
                if let response = response, !response.containsMalformedEmployee() {
                    let employeesSorted = response.employees.sorted(by: { $0.fullName < $1.fullName })
                    employeesSorted.count == 0 ? completion(.empty) : completion(.success(employeesSorted))
                } else {
                    completion(.failure(StringHelper.errorParsing))
                }
            case .failure(let error):
                // Networking failure so pass the error into the error handler and pass through the string
                let networkingError = NetworkingErrorHandler.handleNetworkingError(error)
                completion(.failure(networkingError.localizedString()))
            }
        }
    }
}
