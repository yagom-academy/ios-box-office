//
//  NetworkError.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/22.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case unknown
    case httpResponse
    case httpStatusCode(code: Int)
    case mimeType
    case decode
    
    var description: String {
        switch self{
        case .invalidURL:
            return "Invalid URL"
        case .unknown:
            return "Unknown Error"
        case .httpResponse:
            return "httpResponse Error"
        case .httpStatusCode(code: let code):
            return "Status Code \(code) Error"
        case .mimeType:
            return "mimType Error"
        case .decode:
            return "Decode Error"
        }
    }
}
