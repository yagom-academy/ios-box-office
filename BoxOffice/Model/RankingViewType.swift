//
//  RankingViewType.swift
//  BoxOffice
//
//  Created by Andrew on 2023/04/10.
//

import Foundation

enum RankingViewType {
    case list, icon
    
    var anotherTitle: String {
        switch self {
        case .list:
            return "아이콘"
        case .icon:
            return "리스트"
        }
    }
    
    mutating func toggle() {
        switch self {
        case .list:
            self = .icon
        case .icon:
            self = .list
        }
    }
}
