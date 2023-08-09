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
    case daumImage
    
    var url: String {
        switch self {
        case .boxOffice:
            return "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=%@&targetDt=%@"
        case .movieDetail:
            return "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=%@&movieCd=%@"
        case .daumImage:
            return "https://dapi.kakao.com/v2/search/image"
        }
    }

    static var apiKey: String {
        guard let keyPath = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            return ""
        }
        return keyPath
    }
    static var daumApiKey: String {
        guard let keyPath = Bundle.main.infoDictionary?["DAUM_API_KEY"] as? String else {
            return ""
        }
        return keyPath
    }
}

