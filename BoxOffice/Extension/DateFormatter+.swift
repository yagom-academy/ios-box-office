//
//  DateFormatter+.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/08/03.
//

import Foundation

extension DateFormatter {
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

