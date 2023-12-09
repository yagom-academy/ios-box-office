//
//  DecodingError.swift
//  BoxOffice
//
//  Created by Toy, Morgan on 11/27/23.
//

import Foundation

enum ExecuteRequestError: Error {
    case invalidURL
    case urlSessionError
    case responseError
    case invalidData
    case decodeError
}

extension ExecuteRequestError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "유효하지 않은 URL"
        case .urlSessionError:
            return "URLSession에 대한"
        case .responseError:
            return "response에 대한"
        case .invalidData:
            return "데이터가 유효하지 않음"
        case .decodeError:
            return "디코딩 실패"
        }
    }
}

