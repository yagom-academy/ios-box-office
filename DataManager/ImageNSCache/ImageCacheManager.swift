//
//  ImageCacheManager.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/31.
//

import UIKit

final class ImageCacheManager: DataManager {
    static let shared = ImageCacheManager()
    private let storage = NSCache<NSString, UIImage>()
    
    private init() {}

    func create(key: String, value: [Any]) {
        guard let image = value.first as? UIImage else { return }
        let forKey = NSString(string: key)
        
        self.storage.setObject(image, forKey: forKey)
    }
    
    func read(key: String) -> Any? {
        let cachedKey = NSString(string: key)
        guard let cachedImage = storage.object(forKey: cachedKey) else { return nil }
        
        return cachedImage
    }
    
    func update(key: String, value: [Any]) {
        create(key: key, value: value)
    }
    
    func delete() {
        storage.removeAllObjects()
    }
}
