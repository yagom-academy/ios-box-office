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
        case moviePoster
    }
    
    let service: Service
    var queries: [String: String] = [:]
    private let key = URLQueryItem(name: "key", value: "f5eef3421c602c6cb7ea224104795888")
    
    private var baseURL: String {
        switch service {
        case .dailyBoxOffice:
            return "https://kobis.or.kr/kobisopenapi/webservice/rest"
        case .movieInfo:
            return "https://kobis.or.kr/kobisopenapi/webservice/rest"
        case .moviePoster:
            return "https://dapi.kakao.com"
        }
    }
    
    private var pagePath: String {
        switch service {
        case .dailyBoxOffice:
            return "/boxoffice/searchDailyBoxOfficeList.json?"
        case .movieInfo:
            return "/movie/searchMovieInfo.json?"
        case .moviePoster:
            return "/v2/search/image"
        }
    }
    
    mutating func addQuery(name: String, value: String) {
        self.queries[name] = value
    }
    
    func request() -> URLRequest? {
        var urlComponents = URLComponents(string: baseURL + pagePath)
        
        if service == .moviePoster {
            urlComponents?.queryItems = []
        } else {
            urlComponents?.queryItems = [key]
        }
        
        for (name, value) in queries {
            let queryItem = URLQueryItem(name: name, value: value)
            
            urlComponents?.queryItems?.append(queryItem)
        }
        
        guard let url = urlComponents?.url else { return nil }
        var request = URLRequest(url: url)
        
        if service == .moviePoster {
            request.addValue("KakaoAK 09702eaf2039a2ce4cfacf3fed7cf859", forHTTPHeaderField: "Authorization")
        }
    
        return request
    }
}
