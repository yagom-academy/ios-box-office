//
//  NetworkError.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/07/27.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case notFoundAPIKey
    case requestFailed
    case badStatusCode(statusCode: Int)
    case invalidHTTPResponse
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "유효하지 않은 URL입니다."
        case .notFoundAPIKey:
            return "API KEY를 찾을 수 없습니다. API키를 등록하세요"
        case .requestFailed:
            return "데이터 요청에 실패했습니다."
        case .badStatusCode(let statusCode):
            return "[STATUS CODE: \(statusCode)] 서버에 문제가 있습니다."
        case .invalidHTTPResponse:
            return "유효하지 않은 HTTP Response 입니다."
        }
    }
}
