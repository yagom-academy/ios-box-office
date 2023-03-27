//
//  Identifiable.swift
//  BoxOffice
//
//  Created by Rowan on 2023/03/27.
//

import UIKit

protocol IdentifierType {
    static var identifier: String { get }
}

extension IdentifierType {
    static var identifier: String {
        return String(describing: self)
    }
}
