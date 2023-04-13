//
//  UICollectionView+Animate.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/04/10.
//

import UIKit

extension UICollectionView {
    func fadeIn(_ duration: TimeInterval = 0.3) {
        self.alpha = 0
        UICollectionView.animate(withDuration: duration) { [weak self] in
            self?.alpha = 1
        }
    }
}
