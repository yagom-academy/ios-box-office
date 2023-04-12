//
//  DecodeError.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/21.
//

import Foundation

enum NetworkError {
    case decoding
    case request
    case server
    case imageCreating
}

extension NetworkError: LocalizedError {
    static let title = NSLocalizedString("오류 발생", comment: "Error")
    
    var errorDescription: String? {
        switch self {
        case .decoding:
            return NSLocalizedString("데이터를 디코딩하는데 실패했습니다.", comment: "Data decoding error")
        case .request:
            return NSLocalizedString("네트워크 통신 요청에 실패했습니다.", comment: "Network request error")
        case .server:
            return NSLocalizedString("네트워크 서버에 오류가 발생했습니다.", comment: "Network server error")
        case .imageCreating:
            return NSLocalizedString("이미지 생성에 실패했습니다.", comment: "Image creating error")
        }
    }
}
