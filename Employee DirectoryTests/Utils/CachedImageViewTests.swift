//
//  CachedImageViewTests.swift
//  Employee DirectoryTests
//
//  Created by Bradford Chessin on 3/10/21.
//

import XCTest
@testable import Employee_Directory

class CachedImageViewTests: XCTestCase {
    let uuidKey = "1234"
    var imageView: CachedImageView?
    
    func testInitialState() {
        XCTAssertNil(imageView?.image)
    }
}
