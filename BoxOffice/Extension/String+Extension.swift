//
//  String+Extension.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/04/05.
//

import Foundation

extension String {
    func insertDash() -> String {
        let previousDateFormatter = DateFormatter()
        previousDateFormatter.dateFormat = "yyyyMMdd"
        
        guard let convertDate = previousDateFormatter.date(from: self) else { return ""}
        
        let currentDateFormatter = DateFormatter()
        currentDateFormatter.dateFormat = "yyyy-MM-dd"
        
        let convertString = currentDateFormatter.string(from: convertDate)
        
        return convertString
    }
    
    func insertComma() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        guard let value = Double(self), let result = numberFormatter.string(from: NSNumber(value: value)) else { return "" }
        
        return result
    }
}
