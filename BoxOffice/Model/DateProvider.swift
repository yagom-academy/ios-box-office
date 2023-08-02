//
//  DateProvider.swift
//  BoxOffice
//
//  Created by redmango, Jusbug on 2023/08/02.
//

import Foundation

struct DateProvider {
    var dateFormatter = DateFormatter()
    
    func updateYesterday() -> String? {
        let date = Date()
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: date) else {
            return nil
        }
        
        dateFormatter.dateFormat = "YYYYMMdd"

        return dateFormatter.string(from: yesterday)
    }
}
