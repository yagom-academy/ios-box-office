//
//  URLNamespace.swift
//  BoxOffice
//
//  Created by Yetti, Maxhyunm on 2023/07/27.
//

import Foundation

enum NetworkNamespace {
    case boxOffice
    case movieDetail
    
    var url: String {
        switch self {
        case .boxOffice:
            return "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=%@&targetDt=%@"
        case .movieDetail:
            return "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=%@&movieCd=%@"
        }
    }

    static var apiKey: String {
        guard let keyPath = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            return ""
        }
        return keyPath
    }
}

