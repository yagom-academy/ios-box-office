//
//  Date+.swift
//  BoxOffice
//
//  Created by 김성준 on 2023/03/21.
//

import Foundation

extension Date {
    static var currentDate: String {
        return Date.configureCurrentDate()
    }
    
    private static func configureCurrentDate() -> String {
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        let convertDate = dateFormatter.string(from: nowDate)
                
        return convertDate
    }
}
