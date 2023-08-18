//
//  Reusable.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/07/31.
//

import UIKit

protocol Reusable { }

extension Reusable where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }
}
