//
//  RequestURL.swift
//  BoxOffice
//
//  Created by Hisop on 2023/12/17.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct RequestURL {
    var url: URL
    var method: HTTPMethod
    var header: [String: String]
    
    init(url: URL, method: HTTPMethod = .get, header: [String: String] = [:]) {
        self.url = url
        self.method = method
        self.header = header
    }
    
    var request: URLRequest? {
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        
        for (field, value) in header {
            request.addValue(value, forHTTPHeaderField: field)
        }
        return request
    }
}
