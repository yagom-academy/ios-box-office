//
//  CALayer+.swift
//  BoxOffice
//
//  Created by MARY on 2023/08/04.
//

import UIKit

extension CALayer {
    func addSeparator() {
        let separator = CALayer()
        
        separator.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: 0.5)
        separator.backgroundColor = UIColor.systemGray2.cgColor
        
        self.addSublayer(separator)
    }
}
