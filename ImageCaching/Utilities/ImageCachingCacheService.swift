//
//  ImageCachingCacheService.swift
//  ImageCaching
//
//  Created by Balaganesh on 17/05/23.
//

import UIKit

class ImageCachingCacheService {
    
    static let instance = ImageCachingCacheService()
    
    private let imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 200
        return cache
    }()
    
    private init() {
        
    }
    
    func cacheImage(key: String, image: UIImage) {
        imageCache.setObject(image, forKey: key as NSString)
    }
    
    func getImageFromCache(key: String) -> UIImage? {
        imageCache.object(forKey: key as NSString)
    }
    
}
