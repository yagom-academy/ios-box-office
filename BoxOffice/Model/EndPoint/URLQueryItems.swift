//
//  URLQueryItems.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/21.
//

enum MovieType {
    case diversity
    case commercial
    
    var sign: String {
        switch self {
        case .diversity: return "Y"
        case .commercial: return "N"
        }
    }
}

enum NationalCode {
    case korean
    case foreign
    
    var sign: String {
        switch self {
        case .korean: return "K"
        case .foreign: return "F"
        }
    }
}
