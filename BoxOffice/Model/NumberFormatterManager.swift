//
//  NumberFormatterManager.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/07.
//

import Foundation

final class NumberFormatterManager {
    static let shared = NumberFormatterManager()
    
    private init() { }
    
    private let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter
    }()
    
    func convertToFormattedNumber(from text: String) -> String? {
        guard let number = numberFormatter.number(from: text),
              let stringNumber = numberFormatter.string(from: number) else { return nil }
        
        return stringNumber
    }
}
