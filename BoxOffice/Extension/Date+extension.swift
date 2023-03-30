//
//  Date+extension.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/28.
//

import Foundation

extension Date {
    enum HyphenStatus {
        case existHyphen
        case notHyphen
        
        var format: String {
            switch self {
            case .existHyphen:
                return "yyyy-MM-dd"
            case .notHyphen:
                return "yyyyMMdd"
            }
        }
    }
    
    func showYesterdayDate(formatter: DateFormatter, in status: HyphenStatus) -> String {
        let yesterday = Date().addingTimeInterval(3600 * -24)
        
        formatter.dateFormat = status.format
        
        guard let value = formatter.string(for: yesterday) else { return "" }
        
        return value
    }
}
