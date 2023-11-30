//
//  NetworkManagerError.swift
//  BoxOffice
//
//  Created by Toy, Morgan on 11/29/23.
//

import Foundation

enum NetworkManagerError: Error {
    case notFound
}

extension NetworkManagerError: LocalizedError {
    var errorDescription: String? {
        return "데이터를 불러오지 못하였습니다."
    }
}
