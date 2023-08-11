//
//  CALayer+.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/08/04.
//

import UIKit

extension CALayer {
    func addSeparator(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        let separator = CALayer()
        
        separator.frame = CGRect.init(x: x, y: y, width: width, height: height)
        separator.backgroundColor = UIColor.systemGray2.cgColor
        
        self.addSublayer(separator)
    }
}
