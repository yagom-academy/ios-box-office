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
            throw DecodeError.boxOfficeResultError
        }
    }
}

enum DecodeError: Error {
    case boxOfficeResultError
    
    static let title = NSLocalizedString("오류 발생", comment: "error")
}

extension DecodeError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .boxOfficeResultError:
            return NSLocalizedString("데이터를 불러오는데 실패했습니다.", comment: "data loading failure")
        }
    }
}
