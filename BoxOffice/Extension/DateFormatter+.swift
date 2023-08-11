//
//  DateFormatter+.swift
//  BoxOffice
//
//  Created by Kobe, yyss99 on 2023/08/11.
//

import Foundation

extension DateFormatter {
    func changeDateFormat(_ date: Date, _ format: String) throws -> String {
        self.dateFormat = format
        
        return self.string(from: date)
    }
}

extension DateFormatter {
    enum DateFormat {
        static let hyphen = "yyyy-MM-dd"
        static let attached = "yyyyMMdd"
    }
}
