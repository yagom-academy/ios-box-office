//
//  Identifying.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/24.
//

import UIKit

protocol Identifying {
    static var identifier: String { get }
}

extension Identifying {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewListCell: Identifying { }
