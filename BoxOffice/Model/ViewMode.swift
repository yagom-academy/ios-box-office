//
//  ViewMode.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/08/16.
//

enum ViewMode: String {
    case list
    case icon
    
    var description: String {
        switch self {
        case .list:
            return "리스트"
        case .icon:
            return "아이콘"
        }
    }
}
