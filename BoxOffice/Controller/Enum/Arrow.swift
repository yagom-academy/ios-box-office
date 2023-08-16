//
//  Arrow.swift
//  BoxOffice
//
//  Created by 박종화 on 2023/08/16.
//

import UIKit

enum Arrow: String {
    case upArrow = "▲"
    case downArrow = "▼"
    
    var color: UIColor {
        switch self {
        case .upArrow:
            return .red
        case .downArrow:
            return .blue
        }
    }
    
    init?(rawValue: Int) {
        self = rawValue > 0 ? .upArrow : .downArrow
    }
}
