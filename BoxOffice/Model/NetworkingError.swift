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
    
    var description: String {
        switch self {
        case .connectionFailure:
            return "연결 오류입니다."
        case .notHttpUrlResponse:
            return "잘못된 응답입니다."
        case .invalidResponse(statusCode: let statusCode):
            return "서버 응답 오류입니다. Status Code: \(statusCode)"
        }
    }
}
