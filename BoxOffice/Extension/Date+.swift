//
//  Date+.swift
//  BoxOffice
//
//  Created by JSB on 2023/08/17.
//

import Foundation

extension Date {
    static var yesterday: Date {
        return Date(timeIntervalSinceNow: -86400)
    }
    
    func convertString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        let convertedDate = dateFormatter.string(from: self)
        
        return convertedDate
    }
}
