//
//  APIType.swift
//  BoxOffice
//
//  Created by karen on 2023/08/06.
//

import Foundation

enum APIType {
    case movie(String)
    case boxOffice(String)
    case movieImage(String)
}

extension APIType {
    var urlComponents: URLComponents? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queries
        return urlComponents
    }
    
    var header: String? {
        switch self {
        case .movieImage(_):
            return "KakaoAK " + apiKey
        default:
            return nil
        }
    }

    var apiKey: String {
        switch self {
        case .movie(_), .boxOffice(_):
            return Bundle.main.kobisApiKey
        case .movieImage(_):
            return Bundle.main.kakaoApiKey
        }
    }

    private var scheme: String {
        switch self {
        case .movie(_), .boxOffice(_):
            return "http"
        case .movieImage(_):
            return "https"
        }
    }

    private var host: String {
        switch self {
        case .movie(_), .boxOffice(_):
            return "kobis.or.kr"
        case .movieImage(_):
            return "dapi.kakao.com"
        }
    }

    private var path: String {
        let basePath: String = "/kobisopenapi/webservice/rest/"
        
        switch self {
        case .movie:
            return basePath + "movie/searchMovieInfo.json"
        case .boxOffice:
            return basePath + "boxoffice/searchDailyBoxOfficeList.json"
        case .movieImage:
            return "/v2/search/image"
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
        case .movieImage(let movieName):
            return [URLQueryItem(name: "query", value: "\(movieName)포스터")]
        }
    }
}
