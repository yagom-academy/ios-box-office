//
//  EndPoint.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/22.
//

import Foundation

typealias HTTPHeaders = [String: String]
typealias Query = [String: String]

enum HTTPMethod: String {
    case `get` = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum HTTPTask {
    case requestPlain
    case requestHeader
}

protocol EndpointType {
    var baseURL: URL { get }
    var path: String? { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    func asURLRequest() throws -> URLRequest
}

// MARK: - EndPoint
enum EndPoint {
    case dailyBoxOffice(date: String)
    case movieInfo(movieCode: String)
    case moviePoster(searchFor: String)
    
    var key: String {
        switch self {
        case .dailyBoxOffice:
            return "f5eef3421c602c6cb7ea224104795888"
        case .movieInfo:
            return "f5eef3421c602c6cb7ea224104795888"
        case .moviePoster:
            return "09702eaf2039a2ce4cfacf3fed7cf859"
        }
    }
}

extension EndPoint: EndpointType {
    var baseURL: URL {
        switch self {
        case .dailyBoxOffice:
            guard let url = URL(string: "https://kobis.or.kr/kobisopenapi/webservice/rest") else {
                fatalError("잘못된 baseURL")
            }
            
            return url
        case .movieInfo:
            guard let url = URL(string: "https://kobis.or.kr/kobisopenapi/webservice/rest") else {
                fatalError("잘못된 baseURL")
            }
            
            return url
        case .moviePoster:
            guard let url = URL(string: "https://dapi.kakao.com") else {
                fatalError("잘못된 baseURL")
            }
            
            return url
        }
    }
    
    var path: String? {
        switch self {
        case .dailyBoxOffice:
            return "/boxoffice/searchDailyBoxOfficeList.json"
        case .movieInfo:
            return "/movie/searchMovieInfo.json"
        case .moviePoster:
            return "/v2/search/image"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .dailyBoxOffice:
            return .get
        case .movieInfo:
            return .get
        case .moviePoster:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .dailyBoxOffice:
            return nil
        case .movieInfo:
            return nil
        case .moviePoster:
            return ["Authorization": "KakaoAK \(key)"]
        }
    }
    
    var queries: Query {
        switch self {
        case .dailyBoxOffice(let date):
            return ["key": key, "targetDt": date]
        case .movieInfo(let movieCode):
            return ["key": key, "movieCd": movieCode]
        case .moviePoster(let searchInfo):
            return ["query": searchInfo]
        }
    }
    
    func asURLRequest() -> URLRequest {
        var url: URL = baseURL
        var queryItems: [URLQueryItem] = []
        
        for (name, value) in queries {
            queryItems.append(URLQueryItem(name: name, value: value))
        }
        
        url.appendPathComponent(path ?? "")
        url.append(queryItems: queryItems)
        
        var request: URLRequest = .init(url: url)
        
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = headers
        
        return request
    }
}
