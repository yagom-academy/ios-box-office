//
//  CellMode.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/04/11.
//

enum CellMode: Codable {
    static let identifier = "CellMode"
    
    case List
    case Icon
    
    var alertText: String {
        switch self {
        case .List:
            return "아이콘"
        case .Icon:
            return "리스트"
        }
    }
}
