//
//  BoxOfficeError.swift
//  BoxOffice
//
//  Created by karen on 2023/08/06.
//
import Foundation

enum BoxOfficeError: LocalizedError {
    case invalidURL
    case failureRequest
    case failureResponse
    case unknownError
    case invalidDataType
    case failureDecoding
    case invalidAPIKey
    case failedToGetData
    case failedToGetImage

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "url형식이 잘못되었습니다"
        case .failureRequest:
            return "데이터 요청에 실패했습니다."
        case .failureResponse:
            return "응답이 없습니다."
        case .unknownError:
            return "알 수 없는 에러입니다."
        case .invalidDataType:
            return "올바르지 않는 데이터 포맷입니다"
        case .failureDecoding:
            return "데이터를 변환하지 못하였습니다"
        case .invalidAPIKey:
            return "APIKEY 설정 값이 누락되었거나 잘못된 키값입니다."
        case .failedToGetData:
            return "오류 - 데이터를 받아오지 못하였습니다."
        case .failedToGetImage:
            return "오류 - 이미지를 받아오지 못하였습니다."
        }
    }
}
