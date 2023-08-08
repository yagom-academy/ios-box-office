//
//  DateManager.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/08/03.
//

import Foundation

struct DateManager {
    private var dateFormatter = DateFormatter()
    
    func getYesterdayDate(format: String) -> String {
        let today: Date = Date()
        let calendar: Calendar = Calendar.current
        
        if let yesterday = calendar.date(byAdding: .day, value: -1, to: today) {
            dateFormatter.dateFormat = format
            
            let formattedYesterday: String = dateFormatter.string(from: yesterday)
            
            return formattedYesterday
        }
        
        return "00000000"
    }
}
