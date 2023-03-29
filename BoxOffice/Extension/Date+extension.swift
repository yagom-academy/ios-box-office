//
//  Date+extension.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/28.
//

import Foundation

enum HyphenStatus {
    case existHyphen
    case notHyphen
}

extension Date {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        return dateFormatter
    }()
    
    func showYesterdayDate(format: HyphenStatus) -> String {
        let yesterday = Date().addingTimeInterval((3600 * -24) - 59280)
        
        switch format {
        case .existHyphen:
            Date.dateFormatter.dateFormat = "yyyy-MM-dd"
            
            guard let value = Date.dateFormatter.string(for: yesterday) else { return "0000-00-00" }
            
            return value
        case .notHyphen:
            Date.dateFormatter.dateFormat = "yyMMdd"
            
            guard let value = Date.dateFormatter.string(for: yesterday) else { return "000000" }
            
            return value
        }
    }
}
