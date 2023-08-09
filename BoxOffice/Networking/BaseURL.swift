//
//  BaseURL.swift
//  BoxOffice
//
//  Created by Hyungmin Lee on 2023/07/27.
//

enum BaseURL {
    static let boxOffice = "http://www.kobis.or.kr/kobisopenapi/webservice/rest"
    static let daumSearch = "https://dapi.kakao.com"
}

enum BoxOfficeURLPath {
    static let daily = "/boxoffice/searchDailyBoxOfficeList.json"
    static let movieDetail = "/movie/searchMovieInfo.json"
    
}

enum DaumSearchURLPath {
    static let image = "/v2/search/image"
}
