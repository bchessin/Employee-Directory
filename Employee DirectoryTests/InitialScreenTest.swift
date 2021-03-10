//
//  InitialScreenTest.swift
//  Employee DirectoryTests
//
//  Created by Bradford Chessin on 3/10/21.
//

import XCTest
@testable import Employee_Directory

class InitialScreenTest: XCTestCase {
    func testInitialViewHierarchy() {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
              let window = windowSceneDelegate.window else {
            XCTFail("Could not get scene and/or window")
            return
        }
        
        XCTAssertTrue(window?.rootViewController is UINavigationController)
        
        guard let navigationController = window?.rootViewController as? UINavigationController else {
            XCTFail("Window root not UINavigationController")
            return
        }
        
        let navControllerRoot = navigationController.viewControllers.first
        XCTAssertTrue(navControllerRoot is EmployeesListViewController)
    }
}


