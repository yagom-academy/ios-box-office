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
    var urlComponents: URLComponents? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queries
        return urlComponents
    }

    private var apiKey: String {
        return Bundle.main.apiKey
    }

    private var scheme: String {
        return "http"
    }

    private var host: String {
        return "kobis.or.kr"
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
}
