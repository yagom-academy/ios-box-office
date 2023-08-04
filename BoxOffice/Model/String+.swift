//
//  String+.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/08/04.
//

import Foundation

extension String {
    func decimalStyleFormatter() -> String {
        guard let number = Double(self) else { return "Error" }
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(for: number) ?? "Error"
    }
}
