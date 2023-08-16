//
//  URLType.swift
//  BoxOffice
//
//  Created by 훈민트 on 2023/08/15.
//

import Foundation

enum Scheme {
    static let http = "http"
}

enum HostName {
    static let kobis = "kobis.or.kr"
}

enum Path {
    static let boxOfficeData = "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    static let movieInformation = "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
}

enum Query {
    static let key = URLQueryItem(name: "key", value: "f5eef3421c602c6cb7ea224104795888")
    static var date: URLQueryItem?
    static var code: URLQueryItem?
    
    static func selectDate(_ date: String) {
        self.date = URLQueryItem(name: "targetDt", value: date)
    }
    
    static func selectMovieCode(_ code: String) {
        self.code = URLQueryItem(name: "movieCd", value: code)
    }
}

enum URLType {
    case boxOfficeData
    case movieInformation
    
    var url: URL? {
        switch self {
        case .boxOfficeData:
            return configureURL(path: Path.boxOfficeData, query: [Query.key, Query.date])
        case .movieInformation:
            return configureURL(path: Path.movieInformation, query: [Query.key, Query.code])
        }
    }
    
    private func configureURL(path: String, query: [URLQueryItem?]) -> URL? {
        var component = URLComponents()
        
        component.scheme = Scheme.http
        component.host = HostName.kobis
        component.path = path
        component.queryItems = query.compactMap { $0 }
        
        return component.url
    }
}

