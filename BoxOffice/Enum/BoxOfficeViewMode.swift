//
//  BoxOfficeViewMode.swift
//  BoxOffice
//
//  Created by JSB on 2023/08/18.
//

enum BoxOfficeViewMode: CustomStringConvertible, CaseIterable {
    case list
    case grid
    
    var description: String {
        switch self {
        case .list:
            return "리스트"
        case .grid:
            return "아이콘"
        }
    }
}
