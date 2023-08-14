//
//  DateManager.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/08/03.
//

import Foundation

enum DateManager {
    static private let dateFormatter = DateFormatter()
    
    static func fetchPastDate(dayAgo: Int) -> Date {
        let today: Date = Date()
        let calendar: Calendar = Calendar.current
        
        guard let yesterday = calendar.date(byAdding: .day, value: -dayAgo, to: today) else {
            return today
        }
        
        return yesterday
    }
    
    static func changeDateFormat(date: Date, format: String) -> String {
        dateFormatter.dateFormat = format
        
        let formattedDate: String = dateFormatter.string(from: date)
        
        return formattedDate
    }
}
