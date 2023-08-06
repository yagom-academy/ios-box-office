//
//  KobisAPIType.swift
//  BoxOffice
//
//  Created by karen on 2023/08/06.
//

import Foundation

enum KobisAPIType {
    case movie(String)
    case boxOffice(String)
}

extension KobisAPIType {
    private var apiKey: String {
        switch self {
        case .movie, .boxOffice:
            return Bundle.main.apiKey
        }
    }
    
    private var scheme: String {
        switch self {
        case .movie, .boxOffice:
            return "http"
        }
    }
    
    private var host: String {
        switch self {
        case .movie, .boxOffice:
            return "kobis.or.kr"
        }
    }
    
    private var path: String {
        switch self {
        case .movie:
            return "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
        case .boxOffice:
            return "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        }
    }
    
    private var queries: [URLQueryItem] {
        switch self {
        case .movie(let code):
            return [URLQueryItem(name: "key", value: apiKey),
                    URLQueryItem(name: "movieCd", value: code)]
        case .boxOffice(let date):
            return [URLQueryItem(name: "key", value: apiKey),
                    URLQueryItem(name: "targetDt", value: date)]
        }
    }
    
    func receiveUrl() -> URL? {
        let url = URL(scheme, host, path, queries)
        switch self {
        case .movie(_):
            return url
        case .boxOffice(_):
            return url
        }
    }
}
