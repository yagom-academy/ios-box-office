//
//  NetworkError.swift
//  BoxOffice
//
//  Created by 훈민트 on 2023/08/15.
//

enum NetworkError: Error {
    case dataTaskFail
    case responseCasting
    case invalidStatus
    case noData
    case invalidURL
}
