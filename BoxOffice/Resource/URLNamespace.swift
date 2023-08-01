//
//  URLNamespace.swift
//  BoxOffice
//
//  Created by Yetti, Maxhyunm on 2023/07/27.
//

import Foundation

enum URLNamespace {
    static let boxOffice = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=%@&targetDt=%@"
    static let movieDetail = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=%@&movieCd=%@"
    
    var apiKey: String {
        guard let keyPath = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            return ""
        }
        return keyPath
    }
}
