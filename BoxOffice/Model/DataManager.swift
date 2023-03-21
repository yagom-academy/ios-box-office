//
//  DataManager.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/20.
//

import UIKit

enum DataManager {
    static func parse<T: Decodable>(from data: Data, returnType: T.Type) throws -> T? {
        let decoder = JSONDecoder()
        
        do {
            let result = try decoder.decode(returnType, from: data)
            return result
        } catch {
            throw DecodeError.decodeFail
        }
    }
}

enum DecodeError: Error {
    case decodeFail
    
    static let title = NSLocalizedString("오류 발생", comment: "error")
}

extension DecodeError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodeFail:
            return NSLocalizedString("데이터를 불러오는데 실패했습니다.", comment: "data loading failure")
        }
    }
}
