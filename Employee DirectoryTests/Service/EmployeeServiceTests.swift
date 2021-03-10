//
//  EmployeeServiceTests.swift
//  Employee DirectoryTests
//
//  Created by Bradford Chessin on 3/10/21.
//

import XCTest
@testable import Employee_Directory

class EmployeeServiceTests: XCTestCase {
    func testEmployeeServiceSuccess() {
        let expectation = XCTestExpectation(description: "Employee Service Success")
        let mockNetworkingService = MockNetworkingSuccess()
        let employeeService = EmployeeService(networking: mockNetworkingService)
        employeeService.loadEmployees { (result) in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.count, 2)
                expectation.fulfill()
            case .failure(_), .empty:
                break
            }
        }
    }
    
    func testEmployeeServiceEmptyList() {
        let expectation = XCTestExpectation(description: "Employee Service Empty List")
        let mockNetworkingService = MockNetworkingEmpty()
        let employeeService = EmployeeService(networking: mockNetworkingService)
        employeeService.loadEmployees { (result) in
            switch result {
            case .empty:
                expectation.fulfill()
            case .failure(_), .success(_):
                break
            }
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testEmployeeServiceMalformed() {
        let expectation = XCTestExpectation(description: "Employee Service Malformed List")
        let mockNetworkingService = MockNetworkingFailureMalformed()
        let employeeService = EmployeeService(networking: mockNetworkingService)
        employeeService.loadEmployees { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, StringHelper.errorParsing)
                expectation.fulfill()
            case .success(_), .empty:
                break
            }
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testEmployeeServiceFailure() {
        let expectation = XCTestExpectation(description: "Employee Service Failure")
        let mockNetworkingService = MockNetworkingFailure()
        let employeeService = EmployeeService(networking: mockNetworkingService)
        employeeService.loadEmployees { (result) in
            switch result {
            case .success(_), .empty:
                break
            case .failure(_):
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 3.0)
    }
}
