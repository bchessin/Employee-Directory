//
//  MockSessions.swift
//  Employee DirectoryTests
//
//  Created by Bradford Chessin on 3/10/21.
//

import Foundation
@testable import Employee_Directory

class MockNetworkRequestFailed: NetworkSession {
    var dataTask: MockNetworkRequestMade?
    
    func loadData(from request: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) {
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Failure"])
        completionHandler(nil, error)
    }
}

class MockNetworkRequestSuccess: NetworkSession {    
    func loadData(from request: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) {
        completionHandler(Data(), nil)
    }
}

class MockNetworkRequestMade: URLSessionDataTask {
    var resumeCalled = false
    var completion: (Data?, Error?) -> Void
    
    init(completionHandler: @escaping (Data?, Error?) -> Void) {
        self.completion = completionHandler
    }
    
    override func resume() {
        resumeCalled = true
        completion(Data(), nil)
    }
}
