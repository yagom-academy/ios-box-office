//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Kobe, yyss99 on 2023/07/28.
//

import Foundation

struct NetworkManager {
    func makeURLRequest(baseURL: String, queryItems: [URLQueryItem]) throws -> URLRequest {
        guard var baseURL = URL(string: baseURL) else {
            throw MakeURLRequestError.convertURL
        }
        
        baseURL.append(queryItems: queryItems)
        
        let requestURL = URLRequest(url: baseURL)
        
        return requestURL
    }
}
