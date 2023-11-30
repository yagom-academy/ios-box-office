//
//  DecodingError.swift
//  BoxOffice
//
//  Created by Toy, Morgan on 11/27/23.
//

import Foundation

enum DecodingError: Error {
    case emptyAssetData
}

extension DecodingError: LocalizedError {
    var errorDescription: String? {
        return "에셋 데이터가 없습니다."
    }
}

