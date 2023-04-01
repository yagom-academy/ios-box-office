//
//  NSMutableAttributedString+Extension.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/03/28.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    func makeColorToText(string: String, color: UIColor) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: color]
        append(NSAttributedString(string: string, attributes: attributes))
        
        return self
    }
}
