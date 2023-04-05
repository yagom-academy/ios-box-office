//
//  DateFormmatter+HyphenFormat.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/27.
//

import Foundation

enum DateFormat {
    case hyphen
    case nonHyphen
    
    var expression: String {
        switch self {
        case .hyphen:
            return "YYYY-MM-dd"
        case .nonHyphen:
            return "YYYYMMdd"
        }
    }
}

extension DateFormatter {
    static let dateFormatter = DateFormatter()
    
    static func yesterdayText(format: DateFormat) -> String? {
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            return nil
        }
        
        dateFormatter.dateFormat = format.expression
        
        return dateFormatter.string(from: yesterday)
    }
    
    static func hyphenText(text: String) -> String? {
        dateFormatter.dateFormat = DateFormat.nonHyphen.expression
        
        guard let date = dateFormatter.date(from: text) else { return nil }
        
        dateFormatter.dateFormat = DateFormat.hyphen.expression

        return dateFormatter.string(from: date)
    }
}
