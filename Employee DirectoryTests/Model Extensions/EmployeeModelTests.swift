//
//  EmployeeModelTests.swift
//  Employee DirectoryTests
//
//  Created by Bradford Chessin on 3/10/21.
//

import XCTest
@testable import Employee_Directory

class EmployeeModelTests: XCTestCase {
    func testMalformedEmployeeInList() {
        let mock = MockEmployees()
        if let employees = mock.getMockedMalformedEmployees() {
            XCTAssertTrue(employees.containsMalformedEmployee())
        } else {
            XCTFail("No malformed employees")
        }
    }
}
