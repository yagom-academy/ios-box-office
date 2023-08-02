//
//  BaseURL.swift
//  BoxOffice
//
//  Created by Hyungmin Lee on 2023/07/27.
//

enum BaseURL {
    static let boxOffice = "http://www.kobis.or.kr/kobisopenapi/webservice/rest"
}

enum BoxOfficeURLPath {
    static let daily = "/boxoffice/searchDailyBoxOfficeList.json"
    static let movieDetail = "/movie/searchMovieInfo.json"
}
