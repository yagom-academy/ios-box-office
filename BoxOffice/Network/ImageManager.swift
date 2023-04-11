//
//  ImageManager.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/04/10.
//

import UIKit

final class ImageManager {
    
    static let shared = ImageManager()
    
    static let cache = URLCache(
        memoryCapacity: 500 * 1024 * 1024,
        diskCapacity: 500 * 1024 * 1024,
        directory: cacheDirectory
    )
    
    private static let cacheDirectory = try? FileManager.default.url(
        for: .cachesDirectory,
        in: .userDomainMask,
        appropriateFor: nil,
        create: false
    )
    
    func fetchImage(imageURL: URL, completionHandler: @escaping (Data) -> Void) {
        let urlRequest = URLRequest(url: imageURL)
        
        loadImageFromCache(request: urlRequest) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let imageData):
                completionHandler(imageData)
            case .failure:
                self.downloadImage(request: urlRequest) { imageData in
                    completionHandler(imageData)
                }
            }
        }
    }
    
    private func downloadImage(request: URLRequest, completionHandler: @escaping (Data) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                    (200...299).contains(response.statusCode) else {
                return
            }
            
            let cachedResponse = CachedURLResponse(response: response, data: data)
            ImageManager.cache.storeCachedResponse(cachedResponse, for: request)
            DEBUG_LOG("다운로드 및 캐시 저장 완료")
            completionHandler(data)
        }
        dataTask.resume()
    }
    
    private func loadImageFromCache(request: URLRequest, completionHandler: @escaping(Result<Data, ImageCacheError>) -> Void) {
        if let data = ImageManager.cache.cachedResponse(for: request)?.data {
            completionHandler(.success(data))
            DEBUG_LOG("캐시 이미지 로드 완료")
        } else {
            completionHandler(.failure(.invalidImageData))
        }
    }
    
}
