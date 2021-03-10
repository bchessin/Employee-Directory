//
//  NetworkingRouterTests.swift
//  Employee DirectoryTests
//
//  Created by Bradford Chessin on 3/10/21.
//

import XCTest
@testable import Employee_Directory

class NetworkingRouterTests: XCTestCase {
    func testRouterInitURLArg() {
        guard let url = URL(string: "http://google.com") else {
            XCTFail("URL nil")
            return
        }
        let networkRouter = NetworkingRouter(url: url)
        XCTAssertEqual(networkRouter.url, url)
        XCTAssertEqual(networkRouter.httpMethod, HTTPMethod.get)
    }
    
    func testRouterInitURLHTTPTypeArg() {
        guard let url = URL(string: "http://google.com") else {
            XCTFail("URL nil")
            return
        }
        let networkRouter = NetworkingRouter(url: url, httpMethod: .get)
        XCTAssertEqual(networkRouter.url, url)
        XCTAssertEqual(networkRouter.httpMethod, HTTPMethod.get)
    }
}
