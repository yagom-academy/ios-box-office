//
//  CellConfigurable.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/04/07.
//

import UIKit

protocol CellConfigurable: UICollectionViewCell {
    associatedtype Item
    
    func configure(item: Item)
}
