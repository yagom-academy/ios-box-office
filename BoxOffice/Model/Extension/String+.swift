//
//  String+.swift
//  BoxOffice
//
//  Created by Kiseok on 12/12/23.
//

import Foundation

extension String {
    func numberFormatter() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(for: Int(self)) ?? ""
    }
}
