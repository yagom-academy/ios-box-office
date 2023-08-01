//
//  NetworkError.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/07/31.
//

import Foundation

enum NetworkError: LocalizedError {
    case requestFailed
    case invalidResponse
    case noData
    
    var errorDescription: String? {
        switch self {
        case .requestFailed:
            return "요청이 실패하였습니다."
        case .invalidResponse:
            return "유효하지 않은 응답이거나 성공적인 응답이 아닙니다."
        case .noData:
            return "데이터가 없습니다."
        }
    }
}
