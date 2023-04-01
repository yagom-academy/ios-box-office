//
//  DailyBoxOfficeEndpoint.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/03/31.
//

import Foundation

struct DailyBoxOfficeEndpoint: EndpointMakeable {
    var baseURL: String = Endpoint.baseURL
    var path: String = Endpoint.path
    var method: String = HTTPMethod.get.rawValue
    var queryItems: [URLQueryItem] = [URLQueryItem(name: Endpoint.QueryItemkey, value: Endpoint.QueryItemValue)]
}

