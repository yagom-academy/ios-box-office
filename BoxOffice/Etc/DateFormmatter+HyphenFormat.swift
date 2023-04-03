//
//  DateFormmatter+HyphenFormat.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/27.
//

import Foundation

enum DateFormat: String {
    case hyphen = "YYYY-MM-dd"
    case nonHyphen = "YYYYMMdd"
}

extension DateFormatter {
    static let dateFormatter = DateFormatter()
    
    static func yesterdayText(date: Date) -> String {
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: date) else {
            return ""
        }
        
        dateFormatter.dateFormat = DateFormat.nonHyphen.rawValue
        
        return dateFormatter.string(from: yesterday)
    }
    
    static func hyphenText(text: String) -> String {
        dateFormatter.dateFormat = DateFormat.nonHyphen.rawValue
        
        guard let date = dateFormatter.date(from: text) else { return "" }
        
        dateFormatter.dateFormat = DateFormat.hyphen.rawValue

        return dateFormatter.string(from: date)
    }
    
    static func hyphenText(date: Date) -> String {
        dateFormatter.dateFormat = DateFormat.hyphen.rawValue

        return dateFormatter.string(from: date)
    }
}
