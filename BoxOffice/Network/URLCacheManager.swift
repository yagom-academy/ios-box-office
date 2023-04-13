//
//  URLCacheManager.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/04/11.
//

import Foundation

struct URLCacheManager {
    static let shared = URLCacheManager()
    private var urlCache: URLCache
    
    private init() {
        urlCache = URLCache(memoryCapacity: 0, diskCapacity: 100 * 1024 * 1024)
    }
    
    func cachedResponse(for request: URLRequest) -> CachedURLResponse? {
        guard let response = urlCache.cachedResponse(for: request) else {
            return nil
        }
        
        return response
    }
    
    func createCachedResponse(response: URLResponse?, data: Data) throws -> CachedURLResponse {
        guard let response else {
            throw NetworkError.invalidResponseError
        }
        
        return CachedURLResponse(response: response,
                                 data: data,
                                 userInfo: ["expirationDate": Calendar.current.date(byAdding: .day,
                                                                                    value: 1,
                                                                                    to: Date()) ?? Date()],
                                 storagePolicy: .allowed)
    }
    
    func storeCachedResponse(for cachedResponse: CachedURLResponse, request: URLRequest) {
        urlCache.storeCachedResponse(cachedResponse, for: request)
    }
}
