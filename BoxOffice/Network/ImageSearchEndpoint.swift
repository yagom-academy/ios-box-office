//
//  ImageSearchEndpoint.swift
//  BoxOffice
//
//  Created by kimseongjun on 2023/04/03.
//

import Foundation

struct ImageSearchEndpoint: EndpointMakeable {
    var baseURL: String = Endpoint.kakaoURL
    var path: String = Endpoint.imageSearchPath
    var method: String = HTTPMethod.get.rawValue
    var queryItems: [URLQueryItem] = []
    var header: [String : String]?
}
