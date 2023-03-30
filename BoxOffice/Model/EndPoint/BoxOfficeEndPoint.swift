//
//  BoxOfficeEndPoint.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/21.
//

import Foundation

enum BoxOfficeEndPoint {
    case DailyBoxOffice(tagetDate: String, httpMethod: HttpMethod)
    case MovieInformation(movieCode: String, httpMethod: HttpMethod)
    case MoviePosterImage(query: String, httpMethod: HttpMethod)
}

extension BoxOfficeEndPoint {
    var baseURL: String {
        switch self {
        case .MoviePosterImage:
            return "https://dapi.kakao.com"
        case .DailyBoxOffice, .MovieInformation:
            return "http://www.kobis.or.kr"
        }
    }
    
    var path: String {
        switch self {
        case .DailyBoxOffice:
            return "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        case .MovieInformation:
            return "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
        case .MoviePosterImage:
            return "/v2/search/image"
        }
    }
    
    var key: String {
        get {
            return "f5eef3421c602c6cb7ea224104795888"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .DailyBoxOffice(let targetDate, _):
            return [
                URLQueryItem(name: "key", value: key),
                URLQueryItem(name: "targetDt", value: targetDate)
            ]
        case .MovieInformation(let movieCode, _):
            return [
                URLQueryItem(name: "key", value: key),
                URLQueryItem(name: "movieCd", value: movieCode)
            ]
        case .MoviePosterImage(let query, _):
            return [
                URLQueryItem(name: "query", value: query)
            ]
        }
    }
    
    var httpMethod: String {
        switch self {
        case .DailyBoxOffice(_, let method):
            return method.description
        case .MovieInformation(_, let method):
            return method.description
        case .MoviePosterImage(_, let method):
            return method.description
        }
    }
    
    func createURL() -> URL? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path
        urlComponents?.queryItems = queryItems
        guard let url = urlComponents?.url else { return nil }
        
        return url
    }
    
    func createURLRequest() -> URLRequest? {
        guard let url = createURL() else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod
        
        switch self {
        case .MoviePosterImage:
            urlRequest.setValue("KakaoAK d470dcea6bc2ede97003aac7b84e2533", forHTTPHeaderField: "Authorization")
            return urlRequest
        case .DailyBoxOffice, .MovieInformation:
            return urlRequest
        }
    }
}
