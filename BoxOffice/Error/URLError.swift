//
//  URLError.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/08/01.
//

import Foundation

enum URLError {
    case urlIsNil
}

extension URLError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .urlIsNil:
            return "url이 Nil 입니다."
        }
    }
}
