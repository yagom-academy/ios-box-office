//
//  DecodeError.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/20.
//

enum DecodeError: String, Error {
    case invalidFileError = "NSDataAsset으로 변환하기에 적절한 file이 존재하지 않습니다."
    case decodingFailureError = "해당 file을 디코딩할 수 없습니다."
}
