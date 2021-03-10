//
//  CachedImageView.swift
//  Employee Directory
//
//  Created by Bradford Chessin on 3/10/21.
//

import Foundation
import UIKit

final class CachedImageView: UIImageView {
    private var photoURL: URL?
    private var uuid: String?
    private var networking: Networking
    private var cacheService: CacheService
    static let errorIconName = "ErrorIcon"
    
    init(networking: Networking, cacheService: CacheService) {
        self.networking = networking
        self.cacheService = cacheService
        super.init(image: nil)
    }
    
    // No need for this initializer right now
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .squareDarkGray
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    // MARK: Load Image
    
    // Load an image from a URL into the ImageView.
    func loadImage(from photoEndpoint: String?, withUUID uuid: String?) {
        guard let photoEndpoint = photoEndpoint, let url = URL(string: photoEndpoint) else {
            // URL and/or uuid not passed
            setImage(UIImage(imageLiteralResourceName: CachedImageView.errorIconName))
            return
        }
        
        self.photoURL = url
        self.uuid = uuid
        
        // See if we have the image for specified UUID in the cache already
        if let uuid = uuid, let imageData = cacheService.object(forKey: uuid) {
            if let image = UIImage(data: imageData as Data) {
                setImage(image)
                return
            }
        }
        
        // Leverage networking layer to download the image from the url
        let router = NetworkingRouter(url: url)
        networking.request(router: router) { result in
            switch result {
            case .success(let data):
                // Ensure we can cast data to UIImage
                guard let image: UIImage = UIImage(data: data) else {
                    // Error converting data to image, show default icon
                    self.setImage(UIImage(imageLiteralResourceName: CachedImageView.errorIconName))
                    return
                }
                
                // Set the image to the image view
                self.setImage(image)
                
                // Save image to cache (if uuid isn't nil)
                if let uuid = uuid {
                    self.cacheService.setObject(data, forKey: uuid)
                }
            case .failure(_):
                self.setImage(UIImage(imageLiteralResourceName: CachedImageView.errorIconName))
            }
        }
    }
    
    // MARK: Private Helpers
    
    // Set the image into our ImageView and stop the loading indicator
    private func setImage(_ image: UIImage) {
        self.image = image
        self.loadingIndicator.stopAnimating()
    }
    
    private func setupActivityIndicator() {
        loadingIndicator.removeFromSuperview()
        addSubview(loadingIndicator)
        
        // If we do not have an image already, start the loading indicator
        if self.image == nil {
            loadingIndicator.startAnimating()
        }
        
        // Center our indicator in the image view
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
