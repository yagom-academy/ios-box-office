//
//  Date+.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/21.
//

import Foundation

extension Date {
    static func configureYesterday(isFormatted: Bool) -> String {
        let yesterdayDate = Date(timeIntervalSinceNow: -86400)
        let dateFormatter = DateFormatter()
        
        if isFormatted {
            dateFormatter.dateFormat = "yyyy-MM-dd"
        } else {
            dateFormatter.dateFormat = "yyyyMMdd"
        }
        
        let convertDate = dateFormatter.string(from: yesterdayDate)
                
        return convertDate
    }
    
}

