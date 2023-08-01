//
//  NetworkError.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/07/31.
//

import Foundation

enum NetworkError {
    case requestFail
    case responseFail
    case statusCodeNotSuccess(Int)
    case dataIsNil
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .requestFail:
            return "데이터 요청에 실패했습니다."
        case .responseFail:
            return "응답이 없습니다."
        case .statusCodeNotSuccess(let statusCode):
            return "statusCode가 successful이 아닙니다. [Code: \(statusCode)]"
        case .dataIsNil:
            return "data가 Nil 입니다."
        }
    }
}


