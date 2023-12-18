//
//  Error.swift
//  BoxOffice
//
//  Created by Hisop on 2023/12/04.
//

enum APIError: Error {
    case componentsError
    case dataTaskError
    case invalidStatusCode
    case decodingError
    case noData
}
