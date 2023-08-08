//
//  UILabel+.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/08/08.
//

import UIKit

extension UILabel {
    static func key(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.preferredFont(for: .body, weight: .bold)
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        return label
    }
    
    static func value(text: String?) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        return label
    }
}
