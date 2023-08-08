//
//  ImageCacheManager.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/08/08.
//

import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
