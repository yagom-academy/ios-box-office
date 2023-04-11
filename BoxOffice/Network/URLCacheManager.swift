//
//  URLCacheManager.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/04/11.
//

import Foundation

class URLCacheManager {
    static let shared = URLCacheManager()
    private let storage = URLCache()
    
    private init() { }
    
    func store(response: CachedURLResponse, for url: URL) {
        let urlRequest = URLRequest(url: url)
        storage.storeCachedResponse(response, for: urlRequest)
    }
    
    func getCachedResponse(for dataTask: URLSessionDataTask, completionHandler: @escaping (CachedURLResponse?) -> Void) {
        storage.getCachedResponse(for: dataTask, completionHandler: completionHandler)
    }
}
