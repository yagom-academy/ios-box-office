//
//  RankingViewType.swift
//  BoxOffice
//
//  Created by Andrew on 2023/04/10.
//

import Foundation

enum RankingViewType: Hashable {
    case list, icon
    
    var anotherTitle: String {
        switch self {
        case .list:
            return "아이콘"
        case .icon:
            return "리스트"
        }
    }
}
