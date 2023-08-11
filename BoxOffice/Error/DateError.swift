//
//  DateError.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/08/11.
//

import Foundation

enum DateError {
    case notFoundYesterdayDate
}

extension DateError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFoundYesterdayDate:
            return "어제 날짜를 찾을 수 없습니다.."
        }
    }
}
