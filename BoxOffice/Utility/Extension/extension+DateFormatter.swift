//
//  extension+DateFormatter.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/27.
//

import Foundation

extension DateFormatter {
    public convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}
