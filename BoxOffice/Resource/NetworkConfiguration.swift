//
//  URLNamespace.swift
//  BoxOffice
//
//  Created by Yetti, Maxhyunm on 2023/07/27.
//

import Foundation

enum NetworkConfiguration: Hashable {
    case boxOffice(_ targetDate: String)
    case movieDetail(_ movieCode: String)
    case daumImage(_ movieName: String)
    
    var url: String {
        switch self {
        case .boxOffice(let targetDate):
            return String(format: "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=%@&targetDt=%@", NetworkConfiguration.apiKey, targetDate)
        case .movieDetail(let movieCode):
            return String(format: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=%@&movieCd=%@", NetworkConfiguration.apiKey, movieCode)
        case .daumImage:
            return "https://dapi.kakao.com/v2/search/image"
        }
    }
    
    var query: [(name: String, value: String)] {
        switch self {
        case .daumImage(let movieName):
            return [(name: "query", value: "\(movieName) 영화 포스터")]
        default:
            return []
        }
    }
    
    var header: [(value: String, forHTTPHeaderField: String)] {
        switch self {
        case .daumImage:
            return [(value: "KakaoAK \(NetworkConfiguration.daumApiKey)", forHTTPHeaderField: "Authorization")]
        default:
            return []
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

