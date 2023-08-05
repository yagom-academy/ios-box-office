//
//  DateFormatter+.swift
//  BoxOffice
//
//  Created by Yetti, Maxhyunm on 2023/08/04.
//

import Foundation

extension DateFormatter {
    func formatToString(from date: Date, with format: String) -> String {
        self.dateFormat = format
        
        return self.string(from: date)
    }
}
