//
//  DateGenerator.swift
//  BoxOffice
//
//  Created by  on 12/7/23.
//

import Foundation

struct DateGenerator {
    static func fetchTodayDate() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: currentDate) else { return "" }
        
        let targetDate = dateFormatter.string(from: yesterday)
        
        return targetDate
    }
}
