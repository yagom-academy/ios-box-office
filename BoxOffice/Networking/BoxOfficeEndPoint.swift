//
//  BoxOfficeEndPoint.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/08/16.
//

import Foundation

struct BoxOfficeEndPoint {
    private let scheme: String = "http"
    private let host: String = "www.kobis.or.kr"
    private let urlInformation: URLInformation
    
    var url: URL? {
        var component = URLComponents()
        
        component.scheme = scheme
        component.host = host
        component.path = "/kobisopenapi/webservice/rest" + urlInformation.path
        component.queryItems = urlInformation.queryItems
        return component.url
    }
    
    init(_ urlInformation: URLInformation) {
        self.urlInformation = urlInformation
    }
    
    enum URLInformation {
        case daily(targetDate: String)
        case movieDetail(movieCode: String)
        
        var path: String {
            switch self {
            case .daily:
                return "/boxoffice/searchDailyBoxOfficeList.json"
            case .movieDetail:
                return "/movie/searchMovieInfo.json"
            }
        }
        
        var queryItems: [URLQueryItem] {
            var queryItems: [URLQueryItem] = [URLQueryItem(name: "key", value: APIKey.boxOffice)]
            
            switch self {
            case .daily(let targetDate):
                queryItems.append(URLQueryItem(name: "targetDt", value: targetDate))
            case .movieDetail(let movieCode):
                queryItems.append(URLQueryItem(name: "movieCd", value: movieCode))
            }
            return queryItems
        }
    }
}
