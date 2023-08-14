//
//  BoxOfficeRankingViewType.swift
//  BoxOffice
//
//  Created by karen on 2023/08/15.
//

enum BoxOfficeRankingViewType: Hashable {
    case list, icon
    
    var anotherTitl₩e: String {
        switch self {
        case .list:
            return "아이콘"
        case .icon:
            return "리스트"
        }
    }
}
