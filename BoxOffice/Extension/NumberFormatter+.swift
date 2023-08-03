//
//  NumberFormatter+.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/08/03.
//

import Foundation

extension NumberFormatter {
    func bringDecimalString(_ data: String) -> String {
        self.numberStyle = .decimal
        
        let numberData = Int(data)
        
        guard let formatString = self.string(for: numberData) else {
            return "..."
        }
        
        return formatString
    }
}
