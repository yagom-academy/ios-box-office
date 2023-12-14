//
//  NetworkManagerError.swift
//  BoxOffice
//
//  Created by Toy, Morgan on 11/27/23.
//

import Foundation

enum NetworkManagerError: Error {
    case urlSessionError
    case responseError
    case invalidData
    case decodeError
}

extension NetworkManagerError: LocalizedError {
    var errorDescription: String? {
        switch self {
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

