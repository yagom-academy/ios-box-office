//
//  Int+decimal.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/03/28.
//

import Foundation

extension Int {
    
    var decimalString: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(for: NSNumber(value: self))
    }
    
}
