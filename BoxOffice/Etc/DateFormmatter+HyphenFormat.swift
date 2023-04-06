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
    
    static func nonHyphenText(date: Date) -> String {
        dateFormatter.dateFormat = DateFormat.nonHyphen.rawValue
        
        return dateFormatter.string(from: date)
    }
    
    static func hyphenText(text: String) -> String? {
        dateFormatter.dateFormat = DateFormat.nonHyphen.expression
        
        guard let date = dateFormatter.date(from: text) else { return nil }
        
        dateFormatter.dateFormat = DateFormat.hyphen.expression

        return dateFormatter.string(from: date)
    }
    
    static func hyphenText(date: Date) -> String {
        dateFormatter.dateFormat = DateFormat.hyphen.rawValue

        return dateFormatter.string(from: date)
    }
}
