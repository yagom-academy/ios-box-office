//
//  ImageSearchEndpoint.swift
//  BoxOffice
//
//  Created by kimseongjun on 2023/04/03.
//

import Foundation

struct ImageSearchEndpoint: EndpointMakeable {
    var baseURL: String = Endpoint.kobisURL
    var path: String = Endpoint.kobisPath
    var method: String = HTTPMethod.get.rawValue
    var queryItems: [URLQueryItem] = [URLQueryItem(name: QueryItem.queryItemKey, value: QueryItem.queryItemValue)]
    var header: [String : String]?
}
