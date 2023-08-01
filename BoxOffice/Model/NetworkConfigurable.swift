//
//  NetworkConfigurable.swift
//  BoxOffice
//
//  Created by Kobe, yyss99 on 2023/08/01.
//

import Foundation

public protocol NetworkConfigurable {
    var baseURL: String { get }
    var queryItems: [String: String]? { get }
}

extension NetworkConfigurable {
    public func generateURLRequest() throws -> URLRequest {
        var urlQureyItems: [URLQueryItem] = []
        
        guard var urlComponents = URLComponents(string: baseURL) else {
            throw URLRequestError.convertURL
        }
        
        queryItems?.forEach {
            urlQureyItems.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        
        urlComponents.queryItems = urlQureyItems
        
        guard let url = urlComponents.url else {
            throw URLRequestError.convertURL
        }
        
        let requestURL = URLRequest(url: url)
        
        return requestURL
    }
}
