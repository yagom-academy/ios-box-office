//
//  Int+Exntension.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/04/04.
//

import Foundation

extension Int {
    func convertIntToString() -> String {
        var result = ""
        
        if self < 10 {
            result = "0" + String(self)
        } else {
            return String(self)
        }
        
        return result
    }
}
