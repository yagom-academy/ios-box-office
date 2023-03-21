//
//  String+extension.swift
//  BoxOffice
//
//  Created by 레옹아범 ,Andrew on 2023/03/20.
//

import Foundation

extension String {
    static let numberFormatter = {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        
        return formatter
    }()
    
    func formatDecimal() -> String? {
        guard let value = Int(self),
              let formattedNumber = String.numberFormatter.string(from: NSNumber(value: value)) else { return nil }
        
        return formattedNumber
    }
}
