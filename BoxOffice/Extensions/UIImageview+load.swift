//
//  UIImageView+load.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/03/31.
//

import UIKit

extension UIImageView {
    
    func load(url: URL, originalWidth: Int = 0) {
        let viewWidth = frame.width
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self, let data = try? Data(contentsOf: url) else { return }
            
            let scale = CGFloat(originalWidth) / CGFloat(viewWidth)
            
            let image = UIImage(data: data, scale: scale)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
}
