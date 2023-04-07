//
//  Date+previousDate.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/04/07.
//

import Foundation

extension Date {
    func previousDate() -> Date {
        let previousDate = Calendar.current.date(byAdding: .day, value: -1, to: self)
        
        return previousDate ?? Date()
    }
}
