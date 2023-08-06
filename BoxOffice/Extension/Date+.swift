//
//  Date+.swift
//  BoxOffice
//
//  Created by karen on 2023/08/06.
//

import Foundation

extension Date {
    static var yesterday: Date? {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date())
    }
    
    static let dateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static let apiDateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter
    }()
}

