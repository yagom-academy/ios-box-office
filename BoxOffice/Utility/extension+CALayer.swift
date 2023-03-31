//
//  extension+CALayer.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/28.
//

import UIKit

extension CALayer {
    func addBorder(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
        border.backgroundColor = color.cgColor
        self.addSublayer(border)
    }
}
