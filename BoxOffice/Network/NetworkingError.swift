//
//  NetworkingError.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/21.
//

enum NetworkingError: Error, CustomStringConvertible {
    case decodeFailed
    case dataNotFound
    case clientError
    case serverError
    case unknownError
    case invalidURL
    case transportError(Error)
    
    var description: String {
        switch self {
        case .decodeFailed:
            return "디코딩 실패"
        case .dataNotFound:
            return "찾을 수 없는 데이터"
        case .clientError:
            return "클라이언트 오류 (코드 : 400~499)"
        case .serverError:
            return "서버 오류 (코드 : 500~599)"
        case .unknownError:
            return "알 수 없는 오류"
        case .invalidURL:
            return "잘못된 URL"
        case .transportError(let error):
            return "통신 오류 - \(error)"
        }
    }
}
