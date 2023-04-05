//
//  DateManager.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/04/04.
//

import Foundation

struct DateManager {
    
    static func createYesterdayDate() -> Date {
        let today = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today) ?? today
        return yesterday
    }
    
    static func formattedDateString(of date: Date, option: DateFormatOption) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = option.rawValue
        return dateFormatter.string(from: date)
    }
    
    static func formattedDateString(of dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatOption.numerical.rawValue
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = DateFormatOption.calendar.rawValue
            return dateFormatter.string(from: date)
        }
        return dateString
    }
    
}
