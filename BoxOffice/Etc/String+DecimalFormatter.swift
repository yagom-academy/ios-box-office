//
//  String+DecimalFormatter.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/27.
//

import Foundation

extension String {
    func convertToDecimalText() -> String {
        guard let number = Int(self) else { return "0" }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(for: number) ?? "0"
    }
}
