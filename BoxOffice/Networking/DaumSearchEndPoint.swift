//
//  DaumSearchEndPoint.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/08/16.
//

import Foundation

struct DaumSearchEndPoint {
    private let urlInformation: URLInformation
    private let scheme: String = "https"
    private let host: String = "dapi.kakao.com"
    
    var url: URL? {
        var component = URLComponents()
        
        component.scheme = scheme
        component.host = host
        component.path = urlInformation.path
        component.queryItems = urlInformation.queryItems
        return component.url
    }
    
    init(_ urlInformation: URLInformation) {
        self.urlInformation = urlInformation
    }
    
    enum URLInformation {
        case image(movieName: String)
        
        var path: String {
            switch self {
            case .image:
                return "/v2/search/image"
            }
        }
        
        var queryItems: [URLQueryItem] {
            var queryItems: [URLQueryItem] = []
            
            switch self {
            case .image(let movieName):
                queryItems.append(URLQueryItem(name: "query", value: "\(movieName) 영화 포스터"))
            }
            return queryItems
        }
    }
}
