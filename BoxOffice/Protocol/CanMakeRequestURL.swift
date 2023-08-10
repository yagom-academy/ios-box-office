//
//  CanMakeRequestURL.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/08/10.
//

import Foundation

protocol CanMakeURLRequest {
    func setUpRequestURL(_ baseURL: String,_ path: String, _ queryItems: [String: Any]) -> URLRequest?
}

extension CanMakeURLRequest {
    func setUpRequestURL(_ baseURL: String,_ path: String, _ queryItems: [String: Any]) -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
        
        urlComponents.path += path
        urlComponents.queryItems = queryItems.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        
        guard let url = urlComponents.url else { return nil }
        let urlRequest = URLRequest(url: url)
        
        return urlRequest
    }
}
