//
//  RankIntensity.swift
//  BoxOffice
//
//  Created by by Kobe, yyss99 on 2023/08/16.
//

import UIKit

enum RankIntensity {
    case up(Int)
    case down(Int)
    case stay
    
    init?(fromString string: String) {
        if let value = Int(string), value > 0 {
            self = .up(value)
        } else if let value = Int(string), value < 0 {
            self = .down(value)
        } else if string == "0" {
            self = .stay
        } else {
            return nil
        }
    }
    
    func attributedString(withFont font: UIFont) -> NSAttributedString? {
        var attributedString: NSMutableAttributedString
        let numberAttributedString: NSMutableAttributedString
        
        let returnAttributedString: NSMutableAttributedString = NSMutableAttributedString()
        switch self {
        case .up(let value):
            attributedString = NSMutableAttributedString(string: "▲")
            attributedString.addAttributes([
                .foregroundColor: UIColor.red,
                .font: font
            ], range: NSRange(location: 0, length: attributedString.length))
            
            numberAttributedString = NSMutableAttributedString(string: "\(value)")
            numberAttributedString.addAttributes([
                .foregroundColor: UIColor.black,
                .font: font
            ], range: NSRange(location: 0, length: numberAttributedString.length))
            
            returnAttributedString.append(attributedString)
            returnAttributedString.append(numberAttributedString)
            
        case .down(let value):
            attributedString = NSMutableAttributedString(string: "▼")
            attributedString.addAttributes([
                .foregroundColor: UIColor.blue,
                .font: font
            ], range: NSRange(location: 0, length: attributedString.length))
            
            let valueStr = String(value)
            if let numberOnly = valueStr.last {
                numberAttributedString = NSMutableAttributedString(string: "\(numberOnly)")
                numberAttributedString.addAttributes([
                    .foregroundColor: UIColor.black,
                    .font: font
                ], range: NSRange(location: 0, length: numberAttributedString.length))
                
                returnAttributedString.append(attributedString)
                returnAttributedString.append(numberAttributedString)
            }
            
        case .stay:
            attributedString = NSMutableAttributedString(string: "-")
            attributedString.addAttributes([
                .foregroundColor: UIColor.black,
                .font: font
            ], range: NSRange(location: 0, length: attributedString.length))
            
            returnAttributedString.append(attributedString)
        }
        
        return returnAttributedString
    }
}
