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
    // enum이 밖으로 빠지고 status가 없어야 좀 더 확장성있는 코드가 될 것 같다.
}
