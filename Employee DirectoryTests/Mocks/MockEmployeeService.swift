//
//  MockEmployeeService.swift
//  Employee DirectoryTests
//
//  Created by Bradford Chessin on 3/10/21.
//

import Foundation
@testable import Employee_Directory

class EmployeeServiceFetchSuccess: EmployeeService {
    override func loadEmployees(completion: @escaping (EmployeesServiceResult) -> ()) {
        let directory = MockEmployees().getMockedEmployees()
        let employees = directory?.employees ?? []
        completion(.success(employees))
    }
}

class EmployeeServiceFetchFailure: EmployeeService {
    override func loadEmployees(completion: @escaping (EmployeesServiceResult) -> ()) {
        completion(.failure("Failure"))
    }
}

class EmployeeServiceFetchEmpty: EmployeeService {
    override func loadEmployees(completion: @escaping (EmployeesServiceResult) -> ()) {
        completion(.empty)
    }
}
