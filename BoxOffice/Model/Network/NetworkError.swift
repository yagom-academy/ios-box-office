//
//  NetworkError.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/21.
//

import Foundation

enum NetworkError: LocalizedError {
    case urlError
    case invalidResponseError
    case invalidHttpStatusCode(Int)
    case emptyData
    case decodeError
    
    var errorDescription: String? {
        switch self {
        case .urlError:
            return "잘못된 URL입니다."
        case .invalidResponseError:
            return "알 수 없는 응답 에러입니다."
        case .invalidHttpStatusCode(let code):
            return "status: \(code)"
        case .emptyData:
            return "데이터가 비어있습니다."
        case .decodeError:
            return "decodeError가 발생했습니다."
        }
    }
}
