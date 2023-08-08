//
//  DateFormatter+.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/08/03.
//

import Foundation

extension DateFormatter {
    static let yesterday = {
        guard let date = DateFormatter().date(before: 1) else {
            return Date()
        }
        
        return date
    }()
    
    func dateString(before day: Int, with dateFormat: String) -> String? {
        let currentDate = Date()
        let calendar = Calendar.current
        
        guard let purposeDay = calendar.date(byAdding: .day, value: -day, to: currentDate) else {
            return nil
        }
        
        self.dateFormat = dateFormat
        
        return self.string(from: purposeDay)
    }
    
    func date(before day: Int) -> Date? {
        let currentDate = Date()
        let calendar = Calendar.current
        
        guard let purposeDay = calendar.date(byAdding: .day, value: -day, to: currentDate) else {
            return nil
        }
        
        return purposeDay
    }
    
    func dateString(from date: Date, with dateFormat: String) -> String {
        self.dateFormat = dateFormat
        
        return self.string(from: date)
    }
    
    func dateString(from dateString: String, with dateFormat: String) -> String {
        self.dateFormat = FormatCase.attached
        
        guard let date = self.date(from: dateString) else {
            return dateString
        }
        
        self.dateFormat = dateFormat
        
        return self.string(from: date)
    }
}

extension DateFormatter {
    enum FormatCase {
        static let attached = "yyyyMMdd"
        static let hyphen = "yyyy-MM-dd"
    }
}

