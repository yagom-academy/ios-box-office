//
//  HttpMethod.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/22.
//

enum HttpMethod {
    case get
    case post
    case delete
    
    var description: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .delete:
            return "DELETE"
        }
    }
}
