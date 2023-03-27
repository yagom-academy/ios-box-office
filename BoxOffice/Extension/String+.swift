//
//  String+.swift
//  BoxOffice
//
//  Created by 김성준 on 2023/03/27.
//

import Foundation

extension String {
    
    func formatNumberString() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        guard let number = Int(self) else { return nil }
        
        let formattedNumber = numberFormatter.string(from: NSNumber(value: number))
        return formattedNumber
    }
    
}
