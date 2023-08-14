//
//  UILabel+.swift
//  BoxOffice
//
//  Created by karen on 2023/08/14.
//
import UIKit

extension UILabel {
    convenience init(fontStyle: UIFont, numberOfLine: Int = 1) {
        self.init()
        
        numberOfLines = numberOfLine
        font = fontStyle
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontSizeToFitWidth = true
        adjustsFontForContentSizeCategory = true
    }
}

