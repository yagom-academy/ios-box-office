//
//  ErrorMessage.swift
//  BoxOffice
//
//  Created by Toy, Morgan on 11/27/23.
//

enum DecodingError: Error {
    case emptyAssetData
    
    var description: String {
        switch self {
        case .emptyAssetData:
            return "에셋 데이터가 없습니다."
        }
    }
}
