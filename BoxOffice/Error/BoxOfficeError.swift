//
//  BoxOfficeError.swift
//  BoxOffice
//
//  Created by karen on 2023/08/06.
//
import Foundation

enum BoxOfficeError {
    case urlError
    case requestFail
    case responseFail
    case unknownError
    case typeError
    case decodingFail
    case APIKeyError
}

extension BoxOfficeError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .urlError:
            return "url형식이 잘못되었습니다"
        case .requestFail:
            return "데이터 요청에 실패했습니다."
        case .responseFail:
            return "응답이 없습니다."
        case .unknownError:
            return "알 수 없는 에러입니다."
        case .typeError:
            return "올바르지 않는 데이터 포맷입니다"
        case .decodingFail:
            return "데이터를 변환하지 못하였습니다"
        case .APIKeyError:
            return "APIKEY 설정 값이 누락되었거나 잘못된 키값입니다."
        }
    }
}
