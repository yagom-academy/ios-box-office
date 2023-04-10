//
//  CollectionView+Animate.swift
//  BoxOffice
//
//  Created by kaki on 2023/04/10.
//

import UIKit

extension UICollectionView {
    func fadeIn(_ duration: TimeInterval = 0.4) {
        self.alpha = 0
        self.isHidden = false
        UICollectionView.animate(withDuration: duration,
                       animations: { self.alpha = 1 })
    }
    
    func fadeOut(_ duration: TimeInterval = 0.4) {
        UICollectionView.animate(withDuration: duration,
                       animations: { self.alpha = 0 })
    }
}
