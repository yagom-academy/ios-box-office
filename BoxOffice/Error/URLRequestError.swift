//
//  URLRequestError.swift
//  BoxOffice
//
//  Created by Kobe, yyss99 on 2023/07/28.
//

import Foundation

enum URLRequestError: LocalizedError {
    case convertURL
    
    var errorDescription: String? {
        switch self {
        case .convertURL:
            return "URL로 변경에 실패했습니다."
        }
    }
}
