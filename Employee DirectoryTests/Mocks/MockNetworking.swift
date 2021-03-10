//
//  MockNetworking.swift
//  Employee DirectoryTests
//
//  Created by Bradford Chessin on 3/10/21.
//

import XCTest
@testable import Employee_Directory

class MockNetworkingSuccess: Networking {
    override func request(router: NetworkingRouter, completion: @escaping (NetworkingResult) -> ()) {
        guard let data = MockEmployees().getMockedEmployeesData() else {
            completion(.failure(nil))
            return
        }
        completion(.success(data))
    }
}

class MockNetworkingFailureMalformed: Networking {
    override func request(router: NetworkingRouter, completion: @escaping (NetworkingResult) -> ()) {
        guard let data = MockEmployees().getMockedMalformedEmployeesData() else {
            completion(.failure(nil))
            return
        }
        completion(.success(data))
    }
}

class MockNetworkingEmpty: Networking {
    override func request(router: NetworkingRouter, completion: @escaping (NetworkingResult) -> ()) {
        guard let data = MockEmployees().getMockedEmptyEmployeesData() else {
            completion(.failure(nil))
            return
        }
        completion(.success(data))
    }
}

class MockNetworkingFailure: Networking {
    override func request(router: NetworkingRouter, completion: @escaping (NetworkingResult) -> ()) {
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Failure"])
        completion(.failure(error))
    }
}
