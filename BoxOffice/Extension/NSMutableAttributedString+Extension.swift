//
//  NSMutableAttributedString+Extension.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/03/28.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    func makeRedText(string: String) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.red]
        append(NSAttributedString(string: string, attributes: attributes))
        
        return self
    }
    
    func makeBlueText(string: String) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.blue]
        append(NSAttributedString(string: string, attributes: attributes))
        
        return self
    }
    
    func makeBlackText(string: String) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black]
        append(NSAttributedString(string: string, attributes: attributes))
        
        return self
    }
}


