//
//  MockCacheImageViewSessions.swift
//  Employee DirectoryTests
//
//  Created by Bradford Chessin on 3/10/21.
//

import Foundation
import UIKit
@testable import Employee_Directory

class MockCacheImageViewSessionSuccess: Networking {
    override func request(router: NetworkingRouter, completion: @escaping (NetworkingResult) -> ()) {
        let validImage = UIImage(imageLiteralResourceName: CachedImageView.errorIconName)
        let validData = validImage.pngData()
        completion(.success(validData!))
    }
}

class MockCacheImageViewSessionSuccessInvalidData: Networking {
    override func request(router: NetworkingRouter, completion: @escaping (NetworkingResult) -> ()) {
        completion(.success(Data()))
    }
}

class MockCacheImageViewSessionFailure: Networking {
    override func request(router: NetworkingRouter, completion: @escaping (NetworkingResult) -> ()) {
        completion(.failure(nil))
    }
}

