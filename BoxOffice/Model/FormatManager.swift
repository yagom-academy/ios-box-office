//
//  DateManager.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/08/01.
//

import Foundation

enum FormatManager {
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        
        return formatter
    }()
    
    private static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        return formatter
    }()
    
    static func bringDateString(before day: Int, with dateFomat: String) -> String? {
        let currentDate = Date()
        let calendar = Calendar.current
        
        guard let purposeDay = calendar.date(byAdding: .day, value: -day, to: currentDate) else {
            return nil
        }
        
        dateFormatter.dateFormat = dateFomat
        
        return dateFormatter.string(from: purposeDay)
    }
    
    static func bringDecimalString(_ data: String) -> String? {
        let numberData = Int(data)
        
        return numberFormatter.string(for: numberData)
    }
}

// MARK: Format
extension FormatManager {
    static let dateFormat = "yyyyMMdd"
    static let navigationDateFormat = "yyyy-MM-dd"
}
