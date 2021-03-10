//
//  Employees+Extension.swift
//  Employee Directory
//
//  Created by Bradford Chessin on 3/10/21.
//

import Foundation

extension Employees {
    func containsMalformedEmployee() -> Bool {
        for employee in employees {
            if employee.malformedEmployee() {
                return true
            }
        }
        return false
    }
}
