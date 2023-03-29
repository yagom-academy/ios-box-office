//
//  URLMaker.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/22.
//

import Foundation

enum URLMaker {
    static var baseURL = "https://kobis.or.kr/kobisopenapi/webservice/rest"
    static let key = URLQueryItem(name: "key", value: "f5eef3421c602c6cb7ea224104795888")
    
    case dailyBoxOffice
    case movieInfo
    
    private var pagePath: String {
        switch self {
        case .dailyBoxOffice:
            return "/boxoffice/searchDailyBoxOfficeList.json?"
        case .movieInfo:
            return "/movie/searchMovieInfo.json?"
        }
    }
    
    private var queryItem: URLQueryItem {
        switch self {
        case .dailyBoxOffice:
            return URLQueryItem(name: "targetDt", value: "20230327")
        case .movieInfo:
            return URLQueryItem(name: "movieCd", value: "20124079")
        }
    }
    
    var url: URL? {
        var urlComponents = URLComponents(string: URLMaker.baseURL + pagePath)
        
        urlComponents?.queryItems = [URLMaker.key, queryItem]
        
        return urlComponents?.url
    }
}
