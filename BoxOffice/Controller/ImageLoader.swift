//
//  ImageLoader.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/04/05.
//

import UIKit

final class ImageLoader {
    func loadPosterImage(url: URL?, completion: @escaping (UIImage?) -> ()) {
        guard let url = url else { return }
        
        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: url) else {
                completion(nil)
                return
            }
            
            guard let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            completion(image)
        }
    }
}
