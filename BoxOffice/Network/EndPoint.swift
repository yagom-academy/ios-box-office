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

enum Path: String {
    case dailyBoxOffice = "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    case movieDetail = "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
}

class EndPoint {
        var baseURL: String 
        var path: Path
        var method: HTTPMethod
        var queryItems: [URLQueryItem]
        
    init(baseURL: String, path: Path, method: HTTPMethod, queryItems: [URLQueryItem]) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.queryItems = queryItems
    }
    
    func makeURL() -> URL? {
        var urlComponents = URLComponents(string: baseURL)
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
    
    func makeQueryParameter() {
        
    }
}

enum QueryItemsName: String {
    case key = "key"
    case targetDate = "targetDt"
    case movieCode = "movieCd"
}

enum QueryItemsValue: String {
    case keyValue = "f5eef3421c602c6cb7ea224104795888"
    case targetDateValue = "20230327"
    case movieCodeValue = "20124079"
}

//enum URLAddress: String {
//    static let dailyBoxOfficeURL: String = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=20230327"
//
//    static let movieDetailURL: String = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=f5eef3421c602c6cb7ea224104795888&movieCd=20124079"
//}



