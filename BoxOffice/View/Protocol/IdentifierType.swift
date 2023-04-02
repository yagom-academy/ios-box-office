//
//  IdentifierType.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/04/02.
//

import UIKit

protocol IdentifierType {
    static var identifier: String { get }
}

extension IdentifierType {
    static var identifier: String {
        return String(describing:  self)
    }
}

extension UIViewController: IdentifierType { }
extension UICollectionViewCell: IdentifierType { }
