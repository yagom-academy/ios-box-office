//
//  NetworkError.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/07/31.
//

import Foundation

enum NetworkError {
    case urlIsNil
    case requestFail
    case responseFail
    case statusCodeNotSuccess
    case dataIsNil
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .urlIsNil:
            return "url이 Nil 입니다."
        case .requestFail:
            return "데이터 요청에 실패했습니다."
        case .responseFail:
            return "응답이 없습니다."
        case .statusCodeNotSuccess:
            return "statusCode가 successful이 아닙니다."
        case .dataIsNil:
            return "data가 Nil 입니다."
        }
    }
}


