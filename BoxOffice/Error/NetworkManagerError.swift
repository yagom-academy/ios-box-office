//
//  NetworkManagerError.swift
//  BoxOffice
//
//  Created by Kobe, yyss99 on 2023/08/04.
//

import Foundation

enum NetworkManagerError: LocalizedError {
    case decodedData
    
    var errorDescription: String? {
        switch self {
        case .decodedData:
            return "데이터 디코딩에 실패했습니다."
        }
    }
}
