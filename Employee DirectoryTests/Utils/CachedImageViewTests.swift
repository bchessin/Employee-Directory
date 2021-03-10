//
//  CachedImageViewTests.swift
//  Employee DirectoryTests
//
//  Created by Bradford Chessin on 3/10/21.
//

import XCTest
@testable import Employee_Directory

class CachedImageViewTests: XCTestCase {
    let employeeViewModel = EmployeesListViewModel()
    let uuidKey = "1234"
    var imageView: CachedImageView?
    var cacheService: CacheService?
    
    override func setUp() {
        super.setUp()
        imageView = CachedImageView(networking: employeeViewModel.networkingService, cacheService: employeeViewModel.cacheService)
        cacheService = employeeViewModel.cacheService
    }
    
    func testInitialState() {
        XCTAssertNil(imageView?.image)
    }
    
    func testErrorStateNilURL() {
        imageView?.loadImage(from: nil, withUUID: uuidKey)
        XCTAssertNotNil(imageView?.image)
        
        let cacheData = employeeViewModel.cacheService.object(forKey: uuidKey)
        XCTAssertTrue((cacheData?.isEmpty ?? false) || cacheData == nil)
    }
    
    func testErrorStateEmptyURL() {
        imageView?.loadImage(from: "", withUUID: uuidKey)
        XCTAssertNotNil(imageView?.image)
    }
    
    func testErrorStateUUIDNil() {
        imageView?.loadImage(from: "", withUUID: nil)
        XCTAssertNotNil(imageView?.image)
    }
    
    func testSuccessStateNetworkingValidData() {
        guard let cacheService = cacheService else {
            XCTFail("cache service nil")
            return
        }
        let mockNetwork = MockCacheImageViewSessionSuccess()
        let successImageView = CachedImageView(networking: mockNetwork, cacheService: cacheService)
        successImageView.loadImage(from: "test.com", withUUID: uuidKey)
        
        let cacheData = cacheService.object(forKey: uuidKey)
        XCTAssertNotNil(cacheData)
        XCTAssertNotNil(successImageView.image)
    }
    
    func testSuccessStatePulledFromCache() {
        guard let cacheService = cacheService else {
            XCTFail("cache service nil")
            return
        }
        let mockNetwork = MockCacheImageViewSessionSuccess()
        let successImageView = CachedImageView(networking: mockNetwork, cacheService: cacheService)
        
        // Save data to the image view cache
        let validImage = UIImage(imageLiteralResourceName: CachedImageView.errorIconName)
        guard let validData = validImage.pngData() else {
            XCTFail("Couldn't get image data")
            return
        }
        cacheService.setObject(validData, forKey: uuidKey)
        
        successImageView.loadImage(from: "test.com", withUUID: uuidKey)
        XCTAssertNotNil(successImageView.image)
    }
    
    func testSuccessStateNetworkingInvalidData() {
        guard let cacheService = cacheService else {
            XCTFail("cache service nil")
            return
        }
        let mockNetwork = MockCacheImageViewSessionSuccessInvalidData()
        let successImageView = CachedImageView(networking: mockNetwork, cacheService: cacheService)
        successImageView.loadImage(from: "test.com", withUUID: uuidKey)
        let cacheData = cacheService.object(forKey: uuidKey)
        XCTAssertTrue((cacheData?.isEmpty ?? false) || cacheData == nil)
        XCTAssertNotNil(successImageView.image)
    }
    
    func testSuccessStateNetworkingFailure() {
        guard let cacheService = cacheService else {
            XCTFail("cache service nil")
            return
        }
        let mockNetwork = MockCacheImageViewSessionFailure()
        let successImageView = CachedImageView(networking: mockNetwork, cacheService: cacheService)
        successImageView.loadImage(from: "test.com", withUUID: uuidKey)
        let cacheData = cacheService.object(forKey: uuidKey)
        XCTAssertTrue((cacheData?.isEmpty ?? false) || cacheData == nil)
        XCTAssertNotNil(successImageView.image)
    }
}
