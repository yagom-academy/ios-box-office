//
//  DataError.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/07/28.
//

import Foundation

enum DataError: LocalizedError {
    case decodeJSONFailed
    
    public var errorDescription: String? {
        switch self {
        case .decodeJSONFailed:
            return "JSON 데이터 디코딩에 실패했습니다."
        }
    }
}
