//
//  CacheManager.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/08/08.
//

import UIKit

final class CacheManager {
    static let shared = CacheManager()
    private let imageCache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    
    func setCacheImage(_ image: UIImage, forKey: String) {
        imageCache.setObject(image, forKey: forKey as NSString)
    }
    
    func cacheImage(forKey: String) -> UIImage? {
        return imageCache.object(forKey: forKey as NSString)
    }
}
