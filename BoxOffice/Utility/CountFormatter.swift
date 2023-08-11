//
//  CountFormatter.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/08/07.
//

import Foundation

struct CountFormatter {
    static var decimal: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter
    }()
}
