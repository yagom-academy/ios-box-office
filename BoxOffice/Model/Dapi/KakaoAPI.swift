//
//  KakaoAPI.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/08/09.
//

import Foundation

struct KakaoAPI {
    private let baseURL: URLComponents = {
        var components: URLComponents = URLComponents()
        
        components.scheme = Components.scheme
        components.host = Components.host
        components.path = Components.path
        components.queryItems = []
        
        return components
    }()
    
    func receiveURLRequest(queryItems: [String: String]) throws -> URLRequest {
        var components: URLComponents = baseURL
        
        queryItems.forEach { item in
            let queryItem: URLQueryItem = URLQueryItem(name: item.key, value: item.value)
            
            components.queryItems?.append(queryItem)
        }
        
        guard let url = components.url else {
            throw URLError.urlIsNil
        }
        
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(APIKey.value, forHTTPHeaderField: APIKey.key)
    
        return urlRequest
    }
    
    
    private enum APIKey {
        static let key: String = "Authorization"
        static let value: String = "KakaoAK 5a5bed59f416826d3b667c6d97eac62a"
    }
    
    private enum Components {
        static let scheme: String = "https"
        static let host: String = "dapi.kakao.com"
        static let path: String = "/v2/search/image"
    }
}
