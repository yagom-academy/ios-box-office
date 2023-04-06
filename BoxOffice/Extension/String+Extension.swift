//
//  String+Extension.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/04/05.
//

import Foundation

extension String {
    func removeDashFromDate() -> String {
        let result = self.components(separatedBy: "-").joined()
        return result
    }

    func insertDashFromDate() -> String {
        var result = self
        result.insert("-", at: result.index(result.startIndex, offsetBy: 4))
        result.insert("-", at: result.index(result.endIndex, offsetBy: -2))
        return result
    }
}
