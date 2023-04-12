//
//  AlertActionKeys.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/04/12.
//

enum AlertActionKeys {
    case noAction
    case listAction
    case iconAction
    
    var okActionTitle: String {
        switch self{
        case .listAction:
            return "아이콘"
        case .iconAction:
            return "리스트"
        default:
            return "확인"
        }
    }
}
