//
//  Date+.swift
//  BoxOffice
//
//  Created by Kiseok on 12/14/23.
//

import Foundation

extension Date {
    func yesterday(format: String) -> String {
        let yesterday = Date(timeIntervalSinceNow: DateFormat.forTimeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        guard let dateString = dateFormatter.string(for: yesterday) else {
            return DateFormat.empty
        }
        
        return dateString
    }
}
