//
//  String+.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/08/02.
//

import Foundation

extension String {
    var decimalFormat: Self {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        return formatter.string(from: NSNumber(value: Int(self) ?? Int.min)) ?? ""
    }
}
