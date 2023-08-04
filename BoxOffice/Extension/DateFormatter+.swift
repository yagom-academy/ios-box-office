//
//  DateFormatter+.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/08/03.
//

import Foundation

extension DateFormatter {
    func dateString(before day: Int, with dateFomat: String) -> String? {
        let currentDate = Date()
        let calendar = Calendar.current
        
        guard let purposeDay = calendar.date(byAdding: .day, value: -day, to: currentDate) else {
            return nil
        }
        
        self.dateFormat = dateFomat
        
        return self.string(from: purposeDay)
    }
}

extension DateFormatter {
    enum FormatCase {
        static let attached = "yyyyMMdd"
        static let hyphen = "yyyy-MM-dd"
    }
}

