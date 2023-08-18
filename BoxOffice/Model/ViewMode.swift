//
//  ViewMode.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/08/16.
//

enum ViewMode: String {
    case list = "리스트"
    case icon = "아이콘"
    
    var toggle: ViewMode {
        switch self {
        case .list:
            return .icon
        case .icon:
            return .list
        }
    }
}
