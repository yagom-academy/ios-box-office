//
//  extension+DateFormatter.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/27.
//

import Foundation

extension DateFormatter {
    static let shared = DateFormatter()
    
    func string(from date: Date, dateFormat: String) -> String {
        self.dateFormat = dateFormat

        return self.string(from: date)
    }
    
    func convertFormat(of date: String, from targetFormat: String, to resultFormat: String) -> String? {
        self.dateFormat = targetFormat
        guard let date = DateFormatter.shared.date(from: date) else { return nil }
        
        return self.string(from: date, dateFormat: resultFormat)
    }
}
