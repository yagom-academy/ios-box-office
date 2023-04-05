//
//  MovieDetailEndpoint.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/03/31.
//

import Foundation

struct MovieDetailEndpoint: EndpointMakeable {
    var baseURL: String = "http://kobis.or.kr"
    var path: String = "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
    var method: String = HTTPMethod.get.rawValue
    var queryItems: [URLQueryItem] = [URLQueryItem(name: "key", value: "f5eef3421c602c6cb7ea224104795888")]
    var header: [String : String]?
    
    mutating func insertMovieCodeQueryValue(movieCode: String) {
        queryItems.append(URLQueryItem(name: "movieCd", value: movieCode))
    }
}
