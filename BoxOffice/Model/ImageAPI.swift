//
//  ImageAPI.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/03/31.
//

import Foundation

enum ImageAPI {
    case imageSearchQuery(query: String)
    
    static func imageQuery(_ movieName: String) -> String {
        return "\(movieName) 영화 포스터"
    }
}

extension ImageAPI {
    
    var key: String {
        return imageAPIkey
    }
    
    var baseURL: String {
        return "https://dapi.kakao.com"
    }
    
    var path: String {
        switch self {
        case .imageSearchQuery:
            return "/v2/search/image"
        }
    }
    
    var method: String {
        return HTTPMethod.get
    }
    
    var parameter: [String: String] {
        switch self {
        case .imageSearchQuery(let query):
            return ["query": query, "page": "1", "size": "1"]
        }
    }
    
    var headers: [String: String] {
        return ["Authorization": "KakaoAK \(imageAPIkey)"]
    }
    
}
