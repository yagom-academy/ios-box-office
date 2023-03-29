//
//  NetworkingError.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/21.
//

enum NetworkingError: Error, CustomStringConvertible {
    case decodeFailed
    case dataNotFound
    case clientError(Int)
    case serverError(Int)
    case unknownError(Int)
    case invalidURL
    case transportError(Error)
    
    var description: String {
        switch self {
        case .decodeFailed:
            return "디코딩 실패"
        case .dataNotFound:
            return "찾을 수 없는 데이터"
        case .clientError(let code):
            return "클라이언트 오류 (코드 : \(code))"
        case .serverError(let code):
            return "서버 오류 (코드 : \(code))"
        case .unknownError(let code):
            return "알 수 없는 오류 (코드 : \(code))"
        case .invalidURL:
            return "잘못된 URL"
        case .transportError(let error):
            return "통신 오류 - \(error)"
        }
    }
}
