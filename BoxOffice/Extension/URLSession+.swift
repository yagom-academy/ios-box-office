//
//  URLSession+.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/04/13.
//

import Foundation

extension URLSession {
    static var customCacheShared: URLSession = {
        let memoryCapacity = 10 * 1024 * 1024
        let diskCapacity = 50 * 1024 * 1024
        let cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity)
        
        let config = URLSessionConfiguration.default
        config.urlCache = cache
        
        let session = URLSession(configuration: config)
        
        return session
    }()
}
