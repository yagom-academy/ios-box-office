//
//  DataManager.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/20.
//

import UIKit

enum DataManager {
    static func parse(from data: Data) throws -> DailyBoxOffice? {
        let decoder = JSONDecoder()
        
        do {
            let result = try decoder.decode(DailyBoxOffice.self, from: data)
            return result
        } catch {
            throw DecodeError.decodeFail
        }
    }
}

enum DecodeError: LocalizedError {
    case decodeFail
}

extension DecodeError {
    static let title = NSLocalizedString("오류 발생", comment: "error")
    
    var errorDescription: String? {
        switch self {
        case .decodeFail:
            return NSLocalizedString("데이터 디코딩에 실패했습니다.", comment: "data decoding failure")
        }
    }
}
