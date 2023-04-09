//
//  String+NSMutableAttributed.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/03/28.
//

import UIKit

extension NSMutableAttributedString {
    
    @discardableResult
    func add(
        string: String,
        color: UIColor = .label
    ) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color
        ]
        
        append(NSAttributedString(string: string, attributes: attributes))
        
        return self
    }
    
}
