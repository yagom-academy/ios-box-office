//
//  EndPoint.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/03/28.
//

import Foundation

protocol EndpointMakeable {
    var baseURL: String { get }
    var path: String { get }
    var method: String { get }
    var queryItems: [URLQueryItem] { get }
    var header: [String: String]? { get }
    
    func makeURL() -> URL?
    func makeURLRequest() -> URLRequest?
}

extension EndpointMakeable {
    
    func makeURL() -> URL? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else { return nil }
        
        return url
    }
    
    func makeURLRequest() -> URLRequest? {
        guard let url = makeURL() else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        
        return urlRequest
    }
}
