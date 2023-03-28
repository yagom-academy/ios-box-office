//
//  String+.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/28.
//
import Foundation

extension String {
    func convertToDecimal() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(for: Double(self)) ?? ""
    }
}
