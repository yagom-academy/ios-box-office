//
//  EndPoint.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/24.
//

import Foundation

struct EndPoint: URLRequestGenerator {
    func request(for api: API) -> URLRequest? {
        var urlComponents = URLComponents(string: api.baseURL + api.path)
        urlComponents?.queryItems = []
        
        for (key, value) in api.queries {
            let queryItem = URLQueryItem(name: key , value: value)
            
            urlComponents?.queryItems?.append(queryItem)
        }
        
        guard let url = urlComponents?.url else { return nil }
        
        return URLRequest(url: url)
    }
}

protocol URLRequestGenerator {
    func request(for api: API) -> URLRequest?
}
