//
//  String+.swift
//  BoxOffice
//
//  Created by Yetti, Maxhyunm on 2023/08/04.
//

import Foundation

extension String {
    func formatToDecimalNumber() -> String {
        guard let intData = Int(self) else {
            return self
        }
        
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(for: NSNumber(value: intData)) ?? self
    }
    
    mutating func changeDateFormat() -> String {
        let index1 = self.index(self.startIndex, offsetBy: 4)
        let index2 = self.index(self.startIndex, offsetBy: 6)

        self.insert("-", at: index2)
        self.insert("-", at: index1)

        return self
    }
}


