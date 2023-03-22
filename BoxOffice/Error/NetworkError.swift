//
//  DecodeError.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/21.
//

import Foundation

enum NetworkError: LocalizedError {
    case decodeFail
    case transport
    case invalidURL
    case serverResponse
}

extension NetworkError {
    static let title = NSLocalizedString("오류 발생", comment: "Error")
    
    var errorDescription: String? {
        switch self {
        case .decodeFail:
            return NSLocalizedString("데이터를 디코딩하는데 실패했습니다.", comment: "data decoding Error")
        case .transport:
            return NSLocalizedString("네트워크와 통신하는데 실패했습니다.", comment: "transport Error")
        case .invalidURL:
            return NSLocalizedString("유효하지 않은 URL입니다.", comment: "invalid URL Error")
        case .serverResponse:
            return NSLocalizedString("서버측의 오류가 발생했습니다.", comment: "server response Error")
        }
    }
}
