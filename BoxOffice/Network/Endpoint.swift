//
//  Endpoint.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/24.
//

import Foundation

final class Endpoint {
    let url: String
    let method: HttpMethod
    
    init(url: String, method: HttpMethod) {
        self.url = url
        self.method = method
    }
}

extension Endpoint {
    func urlRequest() -> URLRequest? {
        guard let requestURL = URL(string: url) else {
            return nil
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        
        return request
    }
}
