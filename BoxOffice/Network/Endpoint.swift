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
        
        for (key, value) in api.queries {
            let queryItem = URLQueryItem(name: key , value: value)
            
            urlComponents?.queryItems?.append(queryItem)
        }
        
        guard let url = urlComponents?.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        
        for (key, value) in api.headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        return urlRequest
    }
}
