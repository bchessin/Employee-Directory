//
//  EmployeesListViewModelTests.swift
//  Employee DirectoryTests
//
//  Created by Bradford Chessin on 3/10/21.
//

import XCTest
@testable import Employee_Directory

class EmployeesListViewModelTests: XCTestCase {
    let mock = MockEmployees()
    
    /**
     Note: We don't test malformed list here because that's tested in the employee service layer
     */
    
    func testEmployeesCountEmptyDataSource() {
        let viewModel = EmployeesListViewModel()
        XCTAssert(viewModel.numberOfEmployees() == 0)
    }
    
    func testEmployeesCountValidList() {
        let viewModel = EmployeesListViewModel()
        let employees = mock.getMockedEmployees()
        let employeeList = employees?.employees ?? []
        viewModel.setEmployees(employeeList)
        XCTAssert(viewModel.numberOfEmployees() == 2)
    }
    
    func testEmployeesCountEmptyList() {
        let viewModel = EmployeesListViewModel()
        let employees = mock.getMockedEmptyEmployees()
        let employeeList = employees?.employees ?? []
        viewModel.setEmployees(employeeList)
        XCTAssert(viewModel.numberOfEmployees() == 0)
    }
    
    func testEmployeeAtIndexValidList() {
        let viewModel = EmployeesListViewModel()
        let employees = mock.getMockedEmployees()
        let employeeList = employees?.employees ?? []
        viewModel.setEmployees(employeeList)
        XCTAssertNotNil(viewModel.employeeAt(index: 0))
    }
    
    func testEmployeeAtIndexEmptyList() {
        let viewModel = EmployeesListViewModel()
        let employees = mock.getMockedEmptyEmployees()
        let employeeList = employees?.employees ?? []
        viewModel.setEmployees(employeeList)
        XCTAssertNil(viewModel.employeeAt(index: 0))
    }
    
    func testFetchEmployeesSuccess() {
        let viewModel = EmployeesListViewModel()
        let employeeService = EmployeeServiceFetchSuccess(networking: Networking())
        viewModel.employeeService = employeeService
        
        let numberOfEmployees = MockEmployees().getMockedEmployees()?.employees.count
        
        viewModel.loadEmployees { (result) in
            switch result {
            case .success(let employees):
                XCTAssertEqual(employees.count, numberOfEmployees)
            case .empty:
                XCTFail("Should be a success")
            case .failure(_):
                XCTFail("Should be a success")
            }
        }
    }
    
    func testFetchEmployeesFailure() {
        let viewModel = EmployeesListViewModel()
        let employeeService = EmployeeServiceFetchFailure(networking: Networking())
        viewModel.employeeService = employeeService
        
        let expectation = XCTestExpectation(description: "Network request failure")
        viewModel.loadEmployees { (result) in
            switch result {
            case .failure(_):
                expectation.fulfill()
            case .success(_), .empty:
                break
            }
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testFetchEmployeesEmpty() {
        let viewModel = EmployeesListViewModel()
        let employeeService = EmployeeServiceFetchEmpty(networking: Networking())
        viewModel.employeeService = employeeService
        
        let expectation = XCTestExpectation(description: "Network request empty")
        viewModel.loadEmployees { (result) in
            switch result {
            case .empty:
                expectation.fulfill()
            case .success(_), .failure(_):
                break
            }
        }
        wait(for: [expectation], timeout: 3.0)
    }
}
