//
//  MovieRankMarkColor.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/05.
//

import UIKit

enum MovieRankMarkColor {
    case blue
    case red
    case black
    
    var color: UIColor {
        switch self {
        case .blue:
            return UIColor.systemBlue
        case .red:
            return UIColor.systemRed
        case .black:
            return UIColor.black
        }
    }
}
