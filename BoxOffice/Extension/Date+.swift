//
//  Date+.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/08/09.
//

import Foundation

extension Date {
    static let yesterday = {
        guard let date = date(before: 1) else {
            return Date()
        }
        
        return date
    }()
    
    private static func date(before day: Int) -> Date? {
        let currentDate = Date()
        let calendar = Calendar.current
        
        guard let purposeDay = calendar.date(byAdding: .day, value: -day, to: currentDate) else {
            return nil
        }
        
        return purposeDay
    }
}
