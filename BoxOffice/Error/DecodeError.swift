//
//  DecodeError.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/21.
//

import Foundation

enum DecodeError: LocalizedError {
    case decodeFail
}

extension DecodeError {
    static let title = NSLocalizedString("오류 발생", comment: "error")
    
    var errorDescription: String? {
        switch self {
        case .decodeFail:
            return NSLocalizedString("데이터를 디코딩하는데 실패했습니다.", comment: "data decoding failure")
        }
    }
}
