//
//  Employee+Extension.swift
//  Employee Directory
//
//  Created by Bradford Chessin on 3/10/21.
//

import Foundation

extension Employee {
    func malformedEmployee() -> Bool {
        return
            uuid.isEmpty ||
            fullName.isEmpty ||
            emailAddress.isEmpty ||
            team.isEmpty ||
            employeeType == .none
    }
}
