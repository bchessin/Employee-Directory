//
//  EmployeesListViewModel.swift
//  Employee Directory
//
//  Created by Bradford Chessin on 3/10/21.
//

import Foundation
import UIKit

class EmployeesListViewModel: NSObject {
    private var employees: [Employee]?
    private(set) lazy var networkingService = Networking()
    private(set) lazy var cacheService = CacheService()
    lazy var employeeService = EmployeeService(networking: networkingService)
    
    override init() {
        super.init()
    }
    
    // MARK: Load the employee list
    func loadEmployees(_ completion: @escaping (EmployeesServiceResult) -> ()) {
        employeeService.loadEmployees { result in
            switch result {
            case .success(let directory):
                self.setEmployees(directory)
                completion(.success(directory))
            case .failure(let failure):
                completion(.failure(failure))
            case .empty:
                completion(.empty)
            }
        }
    }
    
    // MARK: Set the employee list
    func setEmployees(_ employeeList: [Employee]) {
        employees = employeeList
    }
    
    // MARK: UITableView Helper Functions
    
    // Returns the number of employees in the "directory"
    func numberOfEmployees() -> Int {
        return employees?.count ?? 0
    }
    
    // Returns the employee at a specified index
    func employeeAt(index: Int) -> Employee? {
        // Ensure we safely grab an employee from the array bounds
        if 0 <= index && index < numberOfEmployees() {
            return employees?[index]
        }
        return nil
    }
}
