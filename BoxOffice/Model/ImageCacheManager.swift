//
//  ImageCacheManager.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/31.
//

import UIKit

final class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
