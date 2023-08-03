//
//  Date+.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/08/03.
//

import Foundation

extension Date {
    func getYesterdayDate(format: String) -> String {
        let today: Date = Date()
        let calendar = Calendar.current
        
        if let yesterday = calendar.date(byAdding: .day, value: -1, to: today) {
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = format
            
            let formattedYesterday = dateFormatter.string(from: yesterday)
            
            return formattedYesterday
        }
        return "00000000"
    }

}

