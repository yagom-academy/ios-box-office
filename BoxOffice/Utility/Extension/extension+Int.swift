//
//  extension+Int.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/04/04.
//

import Foundation

extension Int {
    var doubleDigit: String {
        return String(format: "%02d", self)
    }
}
