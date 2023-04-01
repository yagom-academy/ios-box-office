//
//  extension+String.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/28.
//

import Foundation

extension String {
    func decimal() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: Int(self) as? NSNumber ?? 0)
        
        return result
    }
}
