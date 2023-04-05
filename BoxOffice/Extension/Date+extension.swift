//
//  Date+extension.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/28.
//

import Foundation

extension Date {
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    var yesterday: Date {
        return self.addingTimeInterval(3600 * -24)
    }
        
    func showYesterdayDate(formatter: DateFormatter) -> String {
        guard let value = formatter.string(for: yesterday) else { return "" }
        
        return value
    }
    
    func showSelectedDate(formatter: DateFormatter) -> String {
        guard let value = formatter.string(for: self) else { return "" }
        
        return value
    }
}
