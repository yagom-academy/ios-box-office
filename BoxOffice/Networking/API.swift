//
//  API.swift
//  BoxOffice
//
//  Created by Hyungmin Lee on 2023/07/27.
//

struct APIRequest {
    let baseURL: String
    let path: String?
    let queryItems: [String: Any]?
}

enum APIResult<T> {
    case success(APIResponse<T>)
    case fauilure(APIError)
}

struct APIResponse<T> {
    let data: T
}

enum APIError {
    case fail
}
