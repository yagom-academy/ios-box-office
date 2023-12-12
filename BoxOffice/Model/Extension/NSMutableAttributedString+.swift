//
//  NSMutableAttributedString.swift
//  BoxOffice
//
//  Created by Kiseok on 12/12/23.
//

import UIKit

extension NSMutableAttributedString {
    func body(string: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let font = UIFont.preferredFont(forTextStyle: .body)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }

    func redColor(_ value:String) -> NSMutableAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [
            .font: UIFont.preferredFont(forTextStyle: .body),
            .foregroundColor: UIColor.red
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func blueColor(_ value:String) -> NSMutableAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [
            .font: UIFont.preferredFont(forTextStyle: .body),
            .foregroundColor: UIColor.blue
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}
