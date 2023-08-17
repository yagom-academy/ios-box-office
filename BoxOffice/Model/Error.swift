//
//  BoxOfficeError.swift
//  BoxOffice
//
//  Created by Yetti, Maxhyunm on 2023/07/26.
//

enum NetworkingError: Error {
    case connectionFailure
    case notHttpUrlResponse
    case invalidResponse(statusCode: Int)
    case invalidURL
    case invalidAPIKey
    
    var description: String {
        switch self {
        case .connectionFailure:
            return "연결 오류입니다."
        case .notHttpUrlResponse:
            return "잘못된 응답입니다."
        case .invalidResponse(statusCode: let statusCode):
            return "서버 응답 오류입니다. Status Code: \(statusCode)"
        case .invalidURL:
            return "유효하지 않은 URL입니다."
        case .invalidAPIKey:
            return "유효하지 않은 API Key입니다."
        }
    }
}

enum DecodingError: Error {
    case decodingFailure
    
    var description: String {
        switch self {
        case .decodingFailure:
            return "디코딩 오류입니다."
        }
    }
}
