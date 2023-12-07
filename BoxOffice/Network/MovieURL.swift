//
//  MovieURL.swift
//  BoxOffice
//
//  Created by Toy, Morgan on 11/30/23.
//

import Foundation

enum MovieURL {
    static let schema = "https"
    static let movieHost = "kobis.or.kr"
    static let boxofficePath = "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    static let movieDetailPath = "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
}
