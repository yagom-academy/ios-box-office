//
//  UIImageView+load.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/03/31.
//

import UIKit

extension UIImageView {
   
    func loadImage(url: URL, originalWidth: Int = 0) {
        ImageManager.shared.fetchImage(imageURL: url) { [weak self] data in
            guard let self else { return }
            DispatchQueue.main.async {
                let viewWidth = self.frame.width
                let scale = CGFloat(originalWidth) / CGFloat(viewWidth)
                
                let image = UIImage(data: data, scale: scale)
                self.image = image
            }
        }
    }
    
}
