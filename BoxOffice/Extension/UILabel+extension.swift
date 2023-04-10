//
//  DynamicType.swift
//  BoxOffice
//
//  Created by Andrew on 2023/04/10.
//

import UIKit

extension UILabel {
    
    convenience init(fontStyle: UIFont.TextStyle, numberOfLine: Int = 1) {
        self.init()
        
        numberOfLines = numberOfLine
        font = .preferredFont(forTextStyle: fontStyle)
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontSizeToFitWidth = true
        adjustsFontForContentSizeCategory = true
    }
    
}
