//
//  DateManager.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/08/01.
//

import Foundation

enum DateManager {
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        
        return formatter
    }()
    
    static func bringDate(before day: Int) -> String? {
        let currentDate = Date()
        let calendar = Calendar.current
        
        guard let purposeDay = calendar.date(byAdding: .day, value: -day, to: currentDate) else {
            return nil
        }
        
        return dateFormatter.string(from: purposeDay)
    }
}
