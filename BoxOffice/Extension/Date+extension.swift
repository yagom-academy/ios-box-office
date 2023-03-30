//
//  Date+extension.swift
//  BoxOffice
//
//  Created by 레옹아범 ,Andrew on 2023/03/30.
//

import Foundation

extension Date {
    static var yesterday: Date {
        guard let day = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            return Date()
        }
        return day
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
    
    func formatString() -> String {
        let formattedString = Date.dateFormatter.string(from: self)
        return formattedString
    }
    
    func formatAPIDate() -> String {
        let formattedString = Date.apiDateFormatter.string(from: self)
        return formattedString
    }
}
