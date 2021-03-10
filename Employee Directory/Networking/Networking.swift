//
//  Networking.swift
//  Employee Directory
//
//  Created by Bradford Chessin on 3/10/21.
//

import Foundation

// This project only uses GET but can expand for more functionality in the future
enum HTTPMethod: String {
    case get = "GET"
}

// Either we have a success or failure from a networking call
enum NetworkingResult {
    case success(Data)
    case failure(Error?)
}

protocol NetworkingProtocol {
    func request(router: NetworkingRouter, completion: @escaping (NetworkingResult) -> ())
}

/**
 This is our networking layer which is abstracted and modularized to be used generally across the project.
 A router is passed into this service and this method will return the result in a success/failure enum.
 */
class Networking: NetworkingProtocol {
    private let session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func request(router: NetworkingRouter, completion: @escaping (NetworkingResult) -> ()) {
        // Create the URL from the Router
        guard let url = router.url else {
            // Mare error as nil because the error handler layer will handle this
            completion(.failure(nil))
            return
        }
        
        // Initialize the request 
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.httpMethod?.rawValue
        urlRequest.timeoutInterval = 15
        
        // Start the session
        session.loadData(from: urlRequest) { (data, error) in
            // The callback should be on the main thread
            DispatchQueue.main.async {
                if let data = data {
                    // We have data so return a success and the data
                    completion(.success(data))
                } else  {
                    // Error making call so return failure and the error
                    completion(.failure(error))
                }
            }
        }
    }
}
