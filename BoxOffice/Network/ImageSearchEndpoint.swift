//
//  ImageSearchEndpoint.swift
//  BoxOffice
//
//  Created by kimseongjun on 2023/04/03.
//

import Foundation

struct ImageSearchEndpoint: EndpointMakeable {
    var baseURL: String = "https://dapi.kakao.com"
    var path: String = "/v2/search/image"
    var method: String = HTTPMethod.get.rawValue
    var queryItems: [URLQueryItem] = []
    var header: [String : String]?
    
    mutating func insertImageQueryValue(imageName: String) {
        queryItems.append(URLQueryItem(name: "query", value: "\(imageName) 영화 포스터"))
    }
}
