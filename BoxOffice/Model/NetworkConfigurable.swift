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
            throw NetworkConfigurableError.urlComponents
        }
        
        queryItems?.forEach {
            urlQureyItems.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        
        urlComponents.queryItems = urlQureyItems
        
        guard let url = urlComponents.url else {
            throw NetworkConfigurableError.url
        }
        
        let requestURL = URLRequest(url: url)
        
        return requestURL
    }
    
    public func generateURL(paths: [String]?, isFullPath: Bool) throws -> URL {
        guard let url = URL(string: baseURL) else {
            throw NetworkConfigurableError.url
        }
        
        var baseURL = url.absoluteString
        
        paths?.forEach {
            baseURL += $0
        }
        
        guard var urlComponents = URLComponents(string: baseURL) else {
            throw NetworkConfigurableError.urlComponents
        }
        
        var urlQureyItems: [URLQueryItem] = []
        
        queryItems?.forEach {
            urlQureyItems.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        
        urlComponents.queryItems = !urlQureyItems.isEmpty ? urlQureyItems : nil
        
        let fullPathURL = isFullPath ? URL(string: baseURL) : urlComponents.url
        
        guard let urlResult = fullPathURL else {
            throw NetworkConfigurableError.urlResult
        }
        
        return urlResult
    }
}
