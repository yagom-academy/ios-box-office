//
//  NumberFormat.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/28.
//

import Foundation

extension NumberFormatter {
    static let shared = NumberFormatter()
    
    func decimal(target: String) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: Int(target) as? NSNumber ?? 0)
        
        return result
    }
}
