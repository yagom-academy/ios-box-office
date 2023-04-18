//
//  CALayer+extension.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/31.
//

import UIKit

extension CALayer {
    func drawBorder(color: UIColor, width: CGFloat) {
        let border = CALayer()
        
        border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
        border.backgroundColor = color.cgColor
        self.addSublayer(border)
    }
}
