//
//  RankInfo.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/04/13.
//

import UIKit

enum RankInfo {
    case new
    case noChange
    case increase(Int)
    case decrease(Int)
    
    var description: String {
        switch self {
        case .new:
            return "신작"
        case .noChange:
            return "-"
        case .increase(let variance):
            return "▲\(variance)"
        case .decrease(let variance):
            return "▼\(variance * -1)"
        }
    }
    
    var fontColor: UIColor {
        switch self {
        case .new:
            return .systemRed
        case .noChange:
            return .black
        case .increase:
            return .systemRed
        case .decrease:
            return .systemBlue
        }
    }
}
