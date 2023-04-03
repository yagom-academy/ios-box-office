//
//  MovieDetailEndpoint.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/03/31.
//

import Foundation

struct MovieDetailEndpoint: EndpointMakeable {
    var baseURL: String = Endpoint.kobisURL
    var path: String = Endpoint.movieDetailPath
    var method: String = HTTPMethod.get.rawValue
    var queryItems: [URLQueryItem] = [URLQueryItem(name: QueryItem.queryItemKey, value: QueryItem.queryItemValue)]
    var header: [String : String]?
}
