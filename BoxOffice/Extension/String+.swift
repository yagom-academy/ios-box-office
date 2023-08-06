//
//  String+.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/08/03.
//

import UIKit

extension String {
    func addAttributeFontForKeyword(keyword: String, color: UIColor) -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: self)

        attributeString.addAttribute(.foregroundColor,
                                     value: color,
                                     range: (self as NSString).range(of: keyword))

        return attributeString
    }
}
