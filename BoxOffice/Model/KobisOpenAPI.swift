//
//  KobisOpenAPI.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/07/28.
//

import Foundation

enum KobisOpenAPI {
    case boxOffice(targetDate: String)
    case movie(movieCode: String)
}

extension KobisOpenAPI: URLConfigurable {
    var baseURL: String {
        return "http://www.kobis.or.kr"
    }
    
    var path: String {
        var pathString = "/kobisopenapi/webservice/rest/"
        
        switch self {
        case .boxOffice:
            pathString += "boxoffice/searchDailyBoxOfficeList.json"
        case .movie:
            pathString += "movie/searchMovieInfo.json"
        }
        
        return pathString
    }
    
    var queries: [URLQueryItem] {
        switch self {
        case .boxOffice(let targetDate):
            return [URLQueryItem(name: "key", value: Bundle.main.KOBIS_API_KEY),
                    URLQueryItem(name: "targetDt", value: targetDate)]
        case .movie(let movieCode):
            return [URLQueryItem(name: "key", value: Bundle.main.KOBIS_API_KEY),
                    URLQueryItem(name: "movieCd", value: movieCode)]
        }
    }
    
    var url: URL? {
        return URL(baseURL, path, queries)
    }
}
