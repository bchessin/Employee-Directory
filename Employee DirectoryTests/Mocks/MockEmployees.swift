//
//  MockEmployees.swift
//  Employee DirectoryTests
//
//  Created by Bradford Chessin on 3/10/21.
//

import XCTest
@testable import Employee_Directory

class MockEmployees {
    private func url(for fileName: String) -> URL? {
        let bundle = Bundle(for: MockEmployees.self)       
        let url = bundle.url(forResource: fileName, withExtension: "json")
        return url
    }
    
    private func getEmployees(jsonFileName: String) -> Employees? {
        guard let data = getEmployeesData(jsonFileName: jsonFileName) else {
            return nil
        }
        let response = try? Employees(jsonUTF8Data: data)
        return response
    }
    
    func getMockedEmployees() -> Employees? {
        return getEmployees(jsonFileName: "employees")
    }
    
    func getMockedMalformedEmployees() -> Employees? {
        return getEmployees(jsonFileName: "employees_malformed")
    }
    
    func getMockedEmptyEmployees() -> Employees? {
        return getEmployees(jsonFileName: "employees_empty")
    }
    
    private func getEmployeesData(jsonFileName: String) -> Data? {
        if let path = url(for: jsonFileName) {
            do {
                let data = try Data(contentsOf: path, options: .mappedIfSafe)
                return data
            } catch {
                return nil
            }
        }
        return nil
    }
    
    func getMockedEmployeesData() -> Data? {
        return getEmployeesData(jsonFileName: "employees")
    }
    
    func getMockedMalformedEmployeesData() -> Data? {
        return getEmployeesData(jsonFileName: "employees_malformed")
    }
    
    func getMockedEmptyEmployeesData() -> Data? {
        return getEmployeesData(jsonFileName: "employees_empty")
    }
}
