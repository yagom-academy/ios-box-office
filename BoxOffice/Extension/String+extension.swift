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
    
    func toDate(formatter: DateFormatter) -> Date? {
        formatter.locale = Locale(identifier: "ko-KR")

        guard let date = formatter.date(from: self) else { return nil }
        
        return date
    }
}
