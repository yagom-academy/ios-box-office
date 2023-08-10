//
//  Date+.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/08/02.
//

import Foundation

extension Date {
    static private let formatter = DateFormatter()
    
    static var yesterday: Self {
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            return Date()
        }
        return yesterday
    }
    
    var navigationFormat: String {
        Date.formatter.dateFormat = "YYYY-MM-dd"
        return Date.formatter.string(from: self)
    }
    
    var networkFormat: String {
        Date.formatter.dateFormat = "YYYYMMdd"
        return Date.formatter.string(from: self)
    }    
}
