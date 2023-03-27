//
//  Date+.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/21.
//

import Foundation

extension Date {
    static var yesterday: String {
        return Date.configureYesterdayDate()
    }
    
    private static func configureYesterdayDate() -> String {
        let yesterdayDate = Date(timeIntervalSinceNow: -86400)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        let convertDate = dateFormatter.string(from: yesterdayDate)
                
        return convertDate
    }
}
