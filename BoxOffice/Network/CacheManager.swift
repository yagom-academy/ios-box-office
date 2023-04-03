//
//  CacheManager.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/04/03.
//

import UIKit

final class CacheManager {
    private static let imageCache = NSCache<NSString, UIImage>()
    private static let networkManager = NetworkManager.shared
    
    private init() {}
    
    static func loadImage(imageURL: String, completion: @escaping (UIImage?) -> Void ){
        guard let url = URL(string: imageURL) else { return }
        
        if let cacheImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cacheImage)
        } else {
            guard let url = URL(string: imageURL) else { return }
            let request = URLRequest(url: url)
            
            networkManager.startLoad(request: request, mime: "image") { result in
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)
                    imageCache.setObject(image!, forKey: url.absoluteString as NSString)
                    completion(image)
                case .failure(_):
                    completion(nil)
                }
            }
        }
    }
}
