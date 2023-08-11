//
//  URLRequest+.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/08/11.
//

import Foundation

extension URLRequest {
    static func kakaoURLRequest(_ url: URL, _ key: String?) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue(key, forHTTPHeaderField: HTTPHeaderField.authorization)
        
        return urlRequest
    }
}

extension URLRequest {
    private enum HTTPHeaderField {
        static let authorization = "Authorization"
    }
}
