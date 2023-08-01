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
        
        return formatter
    }()
    
    static func bringDate(before day: Int, with dateFomat: String) -> String? {
        let currentDate = Date()
        let calendar = Calendar.current
        
        guard let purposeDay = calendar.date(byAdding: .day, value: -day, to: currentDate) else {
            return nil
        }
        
        dateFormatter.dateFormat = dateFomat
        
        return dateFormatter.string(from: purposeDay)
    }
}

// MARK: Format
extension DateManager {
    static let dateFormat = "yyyyMMdd"
    static let navigationDateFormat = "yyyy-MM-dd"
}
