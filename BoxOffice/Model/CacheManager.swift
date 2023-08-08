//
//  CacheManager.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/08/08.
//

import UIKit

class CacheManager {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
