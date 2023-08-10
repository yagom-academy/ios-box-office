//
//  APIError.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/07/27.
//

import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case requestFail
    case invalidData
    case decodingFail
    case invalidHTTPStatusCode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "유효하지 않은 URL입니다."
        case .requestFail:
            return "요청에 실패했습니다."
        case .decodingFail:
            return "디코딩 실패 했습니다."
        case .invalidData:
            return "잘못된 데이터 입니다."
        case .invalidHTTPStatusCode:
            return "잘못된 HTTPStatusCode 입니다."
        }
    }
}
