//
//  NetworkError.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/20.
//

import Foundation

enum NetworkError: LocalizedError {
    case responseCodeError
    case invalidResponse
    case invalidMimeType
    case noData
    case responseError(error: Error?)
    
    var errorDescription: String? {
        switch self {
        case .responseCodeError:
            return "response error"
        case .invalidResponse:
            return "비정상적인 response입니다."
        case .invalidMimeType:
            return "Data의 MimeType이 일치하지 않습니다."
        case .noData:
            return "Data가 존재하지 않습니다."
        case .responseError(error: let error):
            return error?.localizedDescription
        }
    }
}
