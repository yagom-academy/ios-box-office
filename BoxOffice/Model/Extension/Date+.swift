//
//  Date+.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/08/02.
//

import Foundation

extension Date {
    static var yesterday: Self {
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            return Date()
        }
        return yesterday
    }
    
    var navigationFormat: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter.string(from: self)
    }
    
    var networkFormat: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYYMMdd"
        return formatter.string(from: self)
    }    
}
