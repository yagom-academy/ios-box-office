//
//  BaseURL.swift
//  BoxOffice
//
//  Created by Hyungmin Lee on 2023/07/27.
//

struct NetworkKey {
    static let boxOffice = "a38f2bee3ae1dc5696060047ce83c935"
}

struct BaseURL {
    static let boxOffice = "http://www.kobis.or.kr"
}

struct BoxOfficeURLPath {
    static let daily = "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    static let movieDetail = "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
}
