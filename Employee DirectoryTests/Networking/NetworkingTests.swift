//
//  NetworkingTests.swift
//  Employee DirectoryTests
//
//  Created by Bradford Chessin on 3/10/21.
//

import XCTest
@testable import Employee_Directory

class NetworkingTests: XCTestCase {
    func testNetworkingRequestFailureNilURL() {
        let router = NetworkingRouter(url: nil, httpMethod: .get)
        let expectation = XCTestExpectation(description: "Request failure")
        Networking().request(router: router) { (result) in
            switch result {
            case .success(_):
                break
            case .failure(_):
                expectation.fulfill()
            }
        }
    }
    
    func testNetworkingCallSuccess() {
        guard let url = URL(string: PredefinedRoute.getEmployees.url) else {
            XCTFail("URL string nil")
            return
        }
        let mockNetwork = MockNetworkRequestSuccess()
        let router = NetworkingRouter(url: url)
        let networking = Networking(session: mockNetwork)
        
        let expectation = XCTestExpectation(description: "Network request success")
        networking.request(router: router) { (result) in
            switch result {
            case .success(_):
                expectation.fulfill()
            case .failure(_):
                break
            }
        }
        
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testNetworkingCallFailed() {
        guard let url = URL(string: PredefinedRoute.getEmployees.url) else {
            XCTFail("URL string nil")
            return
        }
        let mockNetwork = MockNetworkRequestFailed()
        let router = NetworkingRouter(url: url)
        let networking = Networking(session: mockNetwork)
        
        let expectation = XCTestExpectation(description: "Network request failed")
        networking.request(router: router) { (result) in
            switch result {
            case .success(_):
                break
            case .failure(_):
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 3.0)
    }
}
