//
//  CacheServiceTests.swift
//  Employee DirectoryTests
//
//  Created by Bradford Chessin on 3/10/21.
//

import XCTest
@testable import Employee_Directory

class CacheServiceTests: XCTestCase {
    let cacheService = CacheService()
    let uuidKey = "1234"
    let uuidKey2 = "5678"
    
    func testLoadingWithoutSavingReturnsNilFromCache() {
        let data = cacheService.object(forKey: uuidKey)
        XCTAssertNil(data)
    }
    
    func testSaveAndLoadFromCacheSuccess() {
        let origData = Data()
        cacheService.setObject(origData, forKey: uuidKey)
        
        let fetchedData = cacheService.object(forKey: uuidKey)
        XCTAssertNotNil(fetchedData)
        XCTAssertEqual(fetchedData, origData)
    }
    
    func testLowMemoryCacheConditions() {
        let origData = Data()
        cacheService.setObject(origData, forKey: uuidKey)
        
        NotificationCenter.default.post(Notification(name: UIApplication.didReceiveMemoryWarningNotification, object: UIApplication.shared, userInfo: nil))
        
        let fetchedData = cacheService.object(forKey: uuidKey)
        XCTAssertNil(fetchedData)
    }
    
    func testRemoveAllObjects() {
        let origData = Data()
        cacheService.setObject(origData, forKey: uuidKey)
        cacheService.setObject(origData, forKey: uuidKey2)
        cacheService.removeAllObjects()
        
        let origData1 = cacheService.object(forKey: uuidKey)
        let origData2 = cacheService.object(forKey: uuidKey2)
        XCTAssertNil(origData1)
        XCTAssertNil(origData2)
    }
}
