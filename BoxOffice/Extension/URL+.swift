//
//  URL+.swift
//  BoxOffice
//
//  Created by karen on 2023/08/06.
//

import Foundation

extension URL {
    init?(_ scheme: String, _ host: String, _ path: String, _ queries: [URLQueryItem]) {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queries

        guard let url = urlComponents.url else {
            return nil
        }
        
        self = url
    }
}
