//
//  NetworkError.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/07/28.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case requestFailed
    case networkFailed
    case dataFailed
    
    public var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "유효하지 않은 URL입니다."
        case .requestFailed:
            return "요청 실패입니다."
        case .networkFailed:
            return "통신에 실패했습니다."
        case .dataFailed:
            return "잘못된 데이터입니다."
        }
    }
}
