//
//  String+.swift
//  BoxOffice
//
//  Created by karen on 2023/08/14.
//

import Foundation

extension String {
    static let numberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        return formatter
    }()
    
    func formattedDecimalString() -> String? {
        guard let value = Int(self),
              let formattedNumber = String.numberFormatter.string(from: NSNumber(value: value)) else { return nil }
        
        return formattedNumber
    }
}
