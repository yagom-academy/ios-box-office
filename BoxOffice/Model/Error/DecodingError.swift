//
//  DecodingError.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/07/27.
//

import Foundation

enum DecodingError: LocalizedError {
    case decodingFailed
    
    var errorDescription: String? {
        switch self {
        case .decodingFailed:
            return "디코딩에 실패했습니다."
        }
    }
}
