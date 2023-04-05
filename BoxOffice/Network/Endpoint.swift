//
//  Endpoint.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/24.
//

import Foundation

struct Endpoint: URLRequestGenerator {
    func request(for api: API) -> URLRequest? {
        var urlComponents = URLComponents(string: api.baseURL + api.path)
        urlComponents?.queryItems = []
        
        api.queries.forEach { (key, value) in
            let queryItem = URLQueryItem(name: key , value: value)
            
            urlComponents?.queryItems?.append(queryItem)
        }
        
        guard let url = urlComponents?.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        
        api.headers.forEach { (key, value) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        return urlRequest
    }
}
