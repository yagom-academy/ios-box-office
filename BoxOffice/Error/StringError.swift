//
//  StringError.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/08/07.
//

import Foundation

enum StringError {
    case notConvertibleToDouble
    case notConvertibleToString
}

extension StringError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notConvertibleToDouble:
            return "Double 타입으로 변환할 수 없습니다."
        case .notConvertibleToString:
            return "String 타입으로 변환할 수 없습니다."
        }
    }
}
