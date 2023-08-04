//
//  UILabel+.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/08/01.
//

import UIKit

extension UILabel {
    func convertColor(target: String, as color: UIColor) {
        guard let text else {
            return
        }
        
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: target)
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        attributedText = attributedString
    }
}
