//
//  Date+.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/21.
//

import Foundation

extension Date {
    static var yesterday: Date {
        return Date(timeIntervalSinceNow: -86400)
    }
    
    func convertString(isFormatted: Bool) -> String {
        let dateFormatter = DateFormatter()
        
        if isFormatted {
            dateFormatter.dateFormat = "yyyy-MM-dd"
        } else {
            dateFormatter.dateFormat = "yyyyMMdd"
        }
        
        let convertedDate = dateFormatter.string(from: self)
                
        return convertedDate
    }
}

