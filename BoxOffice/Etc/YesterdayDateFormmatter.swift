//
//  DateFormatType.swift
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
    
    static func yesterDayText(format: DateFormat) -> String {
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            return ""
        }
        
        dateFormatter.dateFormat = format.rawValue
        
        return dateFormatter.string(from: yesterday)
    }
    
    static func hyphenText(text: String) -> String {
        guard let date = dateFormatter.date(from: text) else { return "" }
        dateFormatter.dateFormat = DateFormat.hyphen.rawValue

        return dateFormatter.string(from: date)
    }
}
