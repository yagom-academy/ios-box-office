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

enum YesterdayDateFormatter {
    private static let dateFormatter = DateFormatter()
    
    static func text(format: DateFormat) -> String {
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            return ""
        }
        
        dateFormatter.dateFormat = format.rawValue
        
        return dateFormatter.string(from: yesterday)
    }
}
