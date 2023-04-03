//
//  extension+String.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/28.
//

import Foundation

<<<<<<<< HEAD:BoxOffice/Utility/NumberFormat.swift
extension NumberFormatter {
    static let shared = NumberFormatter()
    
    func decimal(target: String) -> String? {
========
extension String {
    func decimal() -> String? {
>>>>>>>> step03-CustomCell:BoxOffice/Utility/Extension/extension+String.swift
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: Int(self) as? NSNumber ?? 0)
        
        return result
    }
}
