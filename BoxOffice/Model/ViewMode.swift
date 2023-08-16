//
//  ViewMode.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/08/16.
//

enum ViewMode: String {
    case list
    case icon
    
    var anotherOption: String {
        switch self {
        case .list:
            return "아이콘"
        case .icon:
            return "리스트"
        }
    }
}
