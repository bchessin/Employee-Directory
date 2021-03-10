//
//  CacheService.swift
//  Employee Directory
//
//  Created by Bradford Chessin on 3/10/21.
//

import Foundation
import UIKit

/**
 This final class is a "caching layer" that provides a very easy to use implementation around the app. Utilizes NSCache
 For the sake of this project it has been kept fairly simple, however we can add costLimits, expiration of certain objects, amongst
 other things fairly easily. 
 */
private let cache = NSCache<NSString, NSData>()
final class CacheService {
    public init() {
        // When the caching layer is instantiated, also add observer in case we have a low memory warning
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onLowMemory),
            name: UIApplication.didReceiveMemoryWarningNotification,
            object: nil)
    }
    
    // If we have a low memory warning, wipe the cache to free up RAM
    @objc private func onLowMemory() {
        removeAllObjects()
    }
    
    // MARK: Open methods
    
    // Grab the object for a specified key and return it if it exists
    func object(forKey key: String) -> Data? {
        if let data = cache.object(forKey: key as NSString) {
            return Data(referencing: data)
        }
        return nil
    }
    
    // Set an object for a specified key
    func setObject(_ object: Data, forKey key: String) {
        cache.setObject(object as NSData, forKey: key as NSString)
    }
    
    // MARK: Private methods
    func removeAllObjects() {
        return cache.removeAllObjects()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
