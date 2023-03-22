//
//  BoxofficeError.swift
//  BoxOffice
//
//  Created by Andrew, 레옹아범 on 2023/03/21.
//

import Foundation

enum BoxofficeError: LocalizedError {
    case urlError
    case sessionError
    case responseError
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .urlError:
            return "url형식이 잘못되었습니다"
        case .sessionError:
            return "네트워크 연결이 불완전합니다"
        case .responseError:
            return "데이터를 받아오지 못하였습니다"
        case .decodingError:
            return "데이터를 변환하지 못하였습니다"
        }
    }
}
