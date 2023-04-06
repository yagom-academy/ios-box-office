//
//  ImageLoader.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/04/03.
//

import UIKit

final class ImageLoader {
    private static let imageCache = NSCache<NSString, UIImage>()
    private static let networkManager = NetworkManager.shared
    
    private init() {}
    
    static func loadImage(imageURL: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void )  {
        guard let url = URL(string: imageURL) else { return }
        
        if let cacheImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(.success(cacheImage))
        } else {
            guard let url = URL(string: imageURL) else { return }
            let request = URLRequest(url: url)
            
            networkManager.startLoad(request: request, mime: "image") { result in
                switch result {
                case .success(let data):
                    guard let image = UIImage(data: data) else {
                        completion(.failure(.noData))
                        return
                    }
                    imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    completion(.success(image))
                case .failure(_):
                    completion(.failure(.invalidResponse))
                }
            }
        }
    }
}
