//
//  URLError.swift
//  BoxOffice
//
//  Created by Toy, Morgan on 12/12/23.
//

import Foundation

enum URLError: Error {
    case invalidURL
}

extension URLError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "유효하지 않은 URL"
        }
    }
}
