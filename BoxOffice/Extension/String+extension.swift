//
//  String+extension.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/29.
//

import UIKit

extension String {
    func applyNumberFormatter(formatter: NumberFormatter) -> String {
        guard let value = formatter.string(for: Int(self)) else { return "0" }
        
        return value
    }
    
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "ko-KR")
        dateFormatter.dateFormat = "yyyyMMdd"
        
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}
