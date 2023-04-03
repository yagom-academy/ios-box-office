//
//  Date+.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/28.
//

import Foundation

extension Date {
    func formatToDate(with form: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = form
        return dateFormatter.string(for: self)
    }
}
