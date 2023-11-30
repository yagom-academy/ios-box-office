//
//  NetworkManagerError.swift
//  BoxOffice
//
//  Created by Toy, Morgan on 11/29/23.
//

enum NetworkManagerError: Error {
    case notFound
    
    var description: String {
        switch self {
        case .notFound:
            return "데이터를 불러오지 못하였습니다."
        }
    }
}
