//
//  HTTP.swift
//  BoxOffice
//
//  Created by 훈민트 on 2023/08/16.
//

enum HTTPMethod {
    case get
    case put
    case post
    case patch
    case delete
    
    var typeName: String {
        switch self {
        case .get:
            return "GET"
        case .put:
            return "PUT"
        case .post:
            return "POST"
        case .patch:
            return "PATCH"
        case .delete:
            return "DELETE"
        }
    }
}
