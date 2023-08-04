//
//  URL+.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/07/28.
//

import Foundation

extension URL {
    static func kobisURL(_ path: String, _ items: [URLQueryItem]) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = Scheme.http
        urlComponents.host = Host.kobis
        urlComponents.path = path
        urlComponents.queryItems = items
        
        return urlComponents.url
    }
}

extension URL {
    private enum Scheme {
        static let http = "http"
    }

    private enum Host {
        static let kobis = "www.kobis.or.kr"
    }
}
