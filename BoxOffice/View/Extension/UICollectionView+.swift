//
//  UICollectionView+.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/08/07.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell & Reusable>(cellClass: T.Type) {
        self.register(cellClass.self, forCellWithReuseIdentifier: cellClass.identifier)
    }
}
