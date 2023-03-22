//
//  NetworkError.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/03/22.
//

import Foundation

enum NetworkError: LocalizedError, CustomStringConvertible {
    
    case clientError
    case serverError
    case invalidURLComponents
    case invalidURLRequest
    
    var description: String {
        switch self {
        case .clientError:
            return "CLINET_ERROR"
        case .serverError:
            return "SERVER_ERRROR"
        case .invalidURLComponents:
            return "INVALID_URL_COMPONENTS"
        case .invalidURLRequest:
            return "INVALID_URL_REQUEST"
        }
    }
    
}
