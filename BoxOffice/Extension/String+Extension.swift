//
//  String+Extension.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/04/05.
//

import Foundation

extension String {
    func insertDashFormatter() -> String {
        let previousDateFormatter = DateFormatter()
        previousDateFormatter.dateFormat = "yyyyMMdd"
        
        guard let convertDate = previousDateFormatter.date(from: self) else { return ""}
        
        let currentDateFormatter = DateFormatter()
        currentDateFormatter.dateFormat = "yyyy-MM-dd"
        
        let convertString = currentDateFormatter.string(from: convertDate)
        
        return convertString
    }
}
