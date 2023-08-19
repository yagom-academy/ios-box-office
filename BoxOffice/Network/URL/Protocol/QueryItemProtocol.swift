//
//  QueryItemProtocol.swift
//  BoxOffice
//
//  Created by 훈민트 on 2023/08/18.
//

import Foundation

protocol QueryItemProtocol {
    var queryItems: [URLQueryItem] { get set }
    
    mutating func addURLQueryItem(APIKey: URLQueryItem, query: [String: String])
}

extension QueryItemProtocol {
    mutating func addURLQueryItem(APIKey: URLQueryItem, query: [String: String]) {
        queryItems.append(APIKey)
        query.keys.forEach { key in
            queryItems.append(URLQueryItem(name: key, value: query[key]))
        }
    }
}
