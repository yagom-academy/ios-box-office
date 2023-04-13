//
//  CellMode.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/04/11.
//

enum CellMode: Codable {
    static let identifier = "CellMode"
    
    case list
    case icon
    
    var alertText: String {
        switch self {
        case .list:
            return "아이콘"
        case .icon:
            return "리스트"
        }
    }
}
