//
//  EndPoint.swift
//  BoxOffice
//
//  Created by kimseongjun on 2023/03/28.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum BaseURL: String {
    case kobis = "http://kobis.or.kr"
}

enum Path: String {
    case dailyBoxOffice = "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    case movieDetail = "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
}

enum QueryItemsName: String {
    case key = "key"
    case targetDate = "targetDt"
    case movieCode = "movieCd"
}

enum QueryItemsValue: String {
    case keyValue = "f5eef3421c602c6cb7ea224104795888"
    case targetDateValue = "20230105"
    case movieCodeValue = "20124079"
}

enum BoxOfficeType {
    case DailyBoxOffice
    case MovieDetail
}

class EndPoint {
        var baseURL: BaseURL
        var path: Path
        var method: HTTPMethod
        var queryItems: [URLQueryItem]
        
    init(baseURL: BaseURL, path: Path, method: HTTPMethod, queryItems: [URLQueryItem]) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.queryItems = queryItems
    }
    
    private func makeURL() -> URL? {
        var urlComponents = URLComponents(string: baseURL.rawValue)
        urlComponents?.path = path.rawValue
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else { return nil }
        
        return url
    }
    
    func makeURLRequest() -> URLRequest? {
        guard let url = makeURL() else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
}



