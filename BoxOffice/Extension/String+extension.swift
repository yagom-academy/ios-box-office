//
//  String+extension.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/29.
//

import UIKit

extension String {
    static let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter
    }()
    
    func applyNumberFormatter() -> String {
        guard let value = String.numberFormatter.string(for: Int(self)) else { return "0" }
        
        return value
    }
    
    func attributeText() -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let range = (self as NSString).range(of: String(self.dropFirst(1)))
        
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: range)
        
        return attributedString
    }
}
