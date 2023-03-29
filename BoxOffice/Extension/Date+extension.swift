//
//  Date+extension.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/28.
//

import Foundation

extension Date {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        return dateFormatter
    }()
    
    func applyHyphenDate() -> String {
        Date.dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let value = Date.dateFormatter.string(for: self) else { return "0000-00-00" }
        
        return value
    }
    
    func applyNotHyphenDate() -> String {
        Date.dateFormatter.dateFormat = "yyMMdd"
        guard let value = Date.dateFormatter.string(for: self) else { return "000000" }
        
        return value
    }
}
