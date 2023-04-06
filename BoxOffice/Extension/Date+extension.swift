//
//  Date+extension.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/28.
//

import Foundation

extension Date {
    func showYesterdayDate(formatter: DateFormatter) -> String {
        let yesterday = Date().addingTimeInterval(3600 * -24)
        
        guard let value = formatter.string(for: yesterday) else { return "" }
        
        return value
    }
}
