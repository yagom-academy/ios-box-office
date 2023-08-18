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

enum URLType {
    case boxOfficeData(query: [URLQueryItem])
    case movieInformation(query: [URLQueryItem])
    
    var url: URL {
        switch self {
        case .boxOfficeData(let query):
            return configureURL(path: Path.boxOfficeData, query: query)
        case .movieInformation(let query):
            return configureURL(path: Path.movieInformation, query: query)
        }
    }
    
    private func configureURL(path: String, query: [URLQueryItem]) -> URL {
        var component = URLComponents()
        
        component.scheme = Scheme.http
        component.host = HostName.kobis
        component.path = path
        component.queryItems = query
        
        guard let url = component.url else {
            fatalError(NetworkError.invalidURL.localizedDescription)
        }
        
        return url
    }
}
