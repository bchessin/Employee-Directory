//
//  NetworkingProtocol.swift
//  Employee Directory
//
//  Created by Bradford Chessin on 3/10/21.
//

import Foundation

protocol NetworkSession {
    func loadData(from request: URLRequest,
                  completionHandler: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func loadData(from request: URLRequest,
                  completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: request) { (data, _, error) in
            completionHandler(data, error)
        }
        task.resume()
    }
}
