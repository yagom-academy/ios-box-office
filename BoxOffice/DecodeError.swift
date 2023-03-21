//
//  DecodeError.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/21.
//

import Foundation

enum DecodeError: Error {
    case decodeFail
    
    static let title = NSLocalizedString("오류 발생", comment: "error")
}

extension DecodeError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodeFail:
            return NSLocalizedString("데이터를 불러오는데 실패했습니다.", comment: "data loading failure")
        }
    }
}
