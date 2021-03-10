//
//  EmployeeListViewControllerTests.swift
//  Employee DirectoryTests
//
//  Created by Bradford Chessin on 3/10/21.
//

import XCTest
@testable import Employee_Directory

class EmployeesListViewControllerTests: XCTestCase {
    var directory: Employees?
    var employees: [Employee]?
    static var employeeList: [Employee] = []
    var listVC = EmployeesListViewController()
    
    override func setUp() {
        super.setUp()
        directory = MockEmployees().getMockedEmployees()
        employees = directory?.employees ?? []
    }
    
    func testTableViewPresent() {
        XCTAssertNotNil(listVC.tableView)
    }
    
    func testTableViewDataSourceResponses() {
        XCTAssertTrue(listVC.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(listVC.responds(to: #selector(listVC.tableView(_:cellForRowAt:))))
        XCTAssertTrue(listVC.responds(to: #selector(listVC.tableView(_:numberOfRowsInSection:))))
    }
    
    func testTableViewSuccessState() {
        guard let employees = employees else {
            XCTFail("Employees nil")
            return
        }
        
        listVC.employeesListViewModel.setEmployees(employees)
        listVC.tableView.reloadData()
        XCTAssert(listVC.tableView.numberOfRows(inSection: 0) == employees.count)
        
        let indexPath = IndexPath(row: 0, section: 0)
        guard let cell = listVC.tableView.cellForRow(at: indexPath) as? EmployeesListCell else {
            XCTFail("No cell or incorrect type")
            return
        }
        
        let firstEmployee = employees.first
        XCTAssertEqual(firstEmployee?.fullName, cell.nameLabel.text)
        XCTAssertEqual(firstEmployee?.team, cell.teamLabel.text)
    }
    
    func testTableViewCellSuccessState() {
        guard let employees = employees else {
            XCTFail("Employees nil")
            return
        }
        
        listVC.employeesListViewModel.setEmployees(employees)
        listVC.tableView.reloadData()
        XCTAssert(listVC.tableView.numberOfRows(inSection: 0) == employees.count)
    }
    
    func testTableViewEmptyOrErrorState() {
        listVC.setupEmptyOrErrorView(withMessage: "Error!")
        let backgroundLabel: UILabel = listVC.tableView.backgroundView as! UILabel
        XCTAssertNotNil(backgroundLabel.text)
    }
}
