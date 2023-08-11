//
//  DateManager.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/08/10.
//

import Foundation

class DateManager {
    static private let dateFormatter = DateFormatter()
    
    static let yesterday: Date = .now - (24 * 60 * 60)
    
    static var selectedDate: Date = yesterday
    
    static var year: String {
        dateFormatter.dateFormat = CustomDateFormatStyle.year
        return dateFormatter.string(from: selectedDate)
    }
    
    static var month: String {
        dateFormatter.dateFormat = CustomDateFormatStyle.month
        return dateFormatter.string(from: selectedDate)
    }
    
    static var day: String {
        dateFormatter.dateFormat = CustomDateFormatStyle.day
        return dateFormatter.string(from: selectedDate)
    }
    
    static var formattedDate: String {
        dateFormatter.dateFormat = CustomDateFormatStyle.yyyyMMdd
        return dateFormatter.string(from: selectedDate)
    }
    
    static var formattedDateWithHyphen: String {
        dateFormatter.dateFormat = CustomDateFormatStyle.yyyyMMddWithHyphen
        return dateFormatter.string(from: selectedDate)
    }
    
    private init() {}
}
