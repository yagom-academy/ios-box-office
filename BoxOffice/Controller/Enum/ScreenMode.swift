//
//  ScreenMode.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/04/05.
//

enum ScreenMode {
    case list
    case icon

    var oppositeTitle: String {
        switch self {
        case .list:
            return "아이콘"
        case .icon:
            return "리스트"
        }
    }
    
    mutating func changeMode() {
        switch self {
        case .list:
            self = .icon
        case .icon:
            self = .list
        }
    }
}
