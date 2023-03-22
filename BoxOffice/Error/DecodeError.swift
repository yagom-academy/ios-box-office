//
//  DecodeError.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/20.
//

import Foundation

enum DecodeError: LocalizedError {
    case invalidFileError
    case decodingFailureError
    
    var errorDescription: String? {
        switch self {
        case .invalidFileError:
            return "NSDataAsset으로 변환하기에 적절한 file이 존재하지 않습니다."
        case .decodingFailureError:
            return "해당 file을 디코딩할 수 없습니다."
        }
    }
}
