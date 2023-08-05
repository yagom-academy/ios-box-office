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
    
    static func kakaoURL(_ path: String, _ items: [URLQueryItem]) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = Scheme.https
        urlComponents.host = Host.kakao
        urlComponents.path = path
        urlComponents.queryItems = items
        
        return urlComponents.url
    }
}

extension URL {
    private enum Scheme {
        static let http = "http"
        static let https = "https"
    }

    private enum Host {
        static let kobis = "www.kobis.or.kr"
        static let kakao = "dapi.kakao.com"
    }
}
