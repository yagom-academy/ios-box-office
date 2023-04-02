//
//  BoxOfficeURLRequest.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/22.
//

import Foundation

struct BoxOfficeURLRequest {
    enum Service {
        case dailyBoxOffice
        case movieInfo
    }
    
    private let baseURL = "https://kobis.or.kr/kobisopenapi/webservice/rest"
    private let key = URLQueryItem(name: "key", value: "f5eef3421c602c6cb7ea224104795888")
    let service: Service
    var queries: [String: String] = [:]
    
    private var pagePath: String {
        switch service {
        case .dailyBoxOffice:
            return "/boxoffice/searchDailyBoxOfficeList.json?"
        case .movieInfo:
            return "/movie/searchMovieInfo.json?"
        }
    }
    
    mutating func addQuery(name: String, value: String) {
        self.queries[name] = value
    }
    
    func request() -> URLRequest? {
        var urlComponents = URLComponents(string: baseURL + pagePath)
        
        urlComponents?.queryItems = [key]
        
        for (name, value) in queries {
            let queryItem = URLQueryItem(name: name, value: value)
            
            urlComponents?.queryItems?.append(queryItem)
        }
        
        guard let url = urlComponents?.url else { return nil }
        
        return URLRequest(url: url)
    }
}
