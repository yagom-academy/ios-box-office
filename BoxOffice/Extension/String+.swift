//
//  String+.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/08/04.
//

import Foundation

extension String {
    func decimalStyleFormatter() throws -> String {
        guard let number = Double(self) else {
            throw StringError.notConvertibleToDouble
        }
        
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .decimal
        
        guard let formattedString = numberFormatter.string(for: number) else {
            throw StringError.notConvertibleToString
        }
        
        return formattedString
    }
}
