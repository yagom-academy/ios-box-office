//
//  String+.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/08/15.
//

extension String {
    mutating func formattedDateWithHyphen() -> String {
        self.insert("-", at: self.index(self.startIndex, offsetBy: 4))
        self.insert("-", at: self.index(self.endIndex, offsetBy: -2))
        
        return self
    }
}
