//
//  NetworkManagerError.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/07/28.
//

enum NetworkManagerError: Error {
    case notExistedUrl
    case cannotLoadFromNetwork
    case failureHttpResponse
}
