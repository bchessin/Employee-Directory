//
//  NetworkingErrorHandlerTests.swift
//  Employee DirectoryTests
//
//  Created by Bradford Chessin on 3/10/21.
//

import XCTest
@testable import Employee_Directory

class NetworkingErrorHandlerTests: XCTestCase {
    func testNilError() {
        let returnedError = NetworkingErrorHandler.handleNetworkingError(nil)
        XCTAssertEqual(returnedError, NetworkingError.generalError)
        XCTAssert(!returnedError.localizedString().isEmpty)
    }
    
    func testTimedOut() {
        let err = NSError(domain: "ResponseError", code: NSURLErrorTimedOut, userInfo: nil)
        let returnedError = NetworkingErrorHandler.handleNetworkingError(err)
        XCTAssertEqual(returnedError, NetworkingError.timedOut)
        XCTAssert(!returnedError.localizedString().isEmpty)
    }
    
    func testConnectionLost() {
        let err = NSError(domain: "ResponseError", code: NSURLErrorNetworkConnectionLost, userInfo: nil)
        let returnedError = NetworkingErrorHandler.handleNetworkingError(err)
        XCTAssertEqual(returnedError, NetworkingError.connectionLost)
        XCTAssert(!returnedError.localizedString().isEmpty)
    }
    
    func testNoResponse() {
        let err = NSError(domain: "ResponseError", code: NSURLErrorCannotConnectToHost, userInfo: nil)
        let returnedError = NetworkingErrorHandler.handleNetworkingError(err)
        XCTAssertEqual(returnedError, NetworkingError.noResponse)
        XCTAssert(!returnedError.localizedString().isEmpty)
    }
    
    func testOtherError() {
        let err = NSError(domain: "ResponseError", code: NSURLErrorCannotLoadFromNetwork, userInfo: nil)
        let returnedError = NetworkingErrorHandler.handleNetworkingError(err)
        XCTAssertEqual(returnedError, NetworkingError.generalError)
        XCTAssert(!returnedError.localizedString().isEmpty)
    }
}
