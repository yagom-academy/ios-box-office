//
//  BoxOfficeEndPoint.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/22.
//

import Foundation

enum BoxOfficeEndPoint {
    case fetchDailyBoxOffice(targetDate: String)
    case fetchMovieInfo(movieCode: String)
    case fetchMoviePoster(movieName: String)
}

extension BoxOfficeEndPoint {
    var baseURLString: String {
        switch self {
        case .fetchDailyBoxOffice, .fetchMovieInfo:
            return "https://www.kobis.or.kr"
        case .fetchMoviePoster:
            return "https://dapi.kakao.com"
        }
    }
    
    var key: String {
        return "561b75157b06468741f6271d76fe4e9a"
    }
    
    var path: String {
        switch self {
        case .fetchDailyBoxOffice:
            return "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        case .fetchMovieInfo:
            return "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
        case .fetchMoviePoster:
            return "/v2/search/image"
        }
    }
    
    var queries: [URLQueryItem] {
        switch self {
        case .fetchDailyBoxOffice(let targetDate):
            return [
                URLQueryItem(name: "key", value: key),
                URLQueryItem(name: "targetDt", value: targetDate)
            ]
        case .fetchMovieInfo(let movieCode):
            return [
                URLQueryItem(name: "key", value: key),
                URLQueryItem(name: "movieCd", value: movieCode)
            ]
        case .fetchMoviePoster(let movieName):
            return [
                URLQueryItem(name: "query", value: movieName + " 영화 포스터")
            ]
        }
    }
    
    func createRequest() -> URLRequest? {
        switch self {
        case .fetchDailyBoxOffice, .fetchMovieInfo:
            var components = URLComponents(string: baseURLString)
            components?.path = path
            components?.queryItems = queries
            
            guard let url = components?.url else { return nil }
            
            let request = URLRequest(url: url)
            
            return request
        case .fetchMoviePoster:
            var components = URLComponents(string: baseURLString)
            components?.path = path
            components?.queryItems = queries
            
            guard let url = components?.url else { return nil }
            
            var request = URLRequest(url: url)
            request.addValue("KakaoAK 5b4b66233a752c37813727124f19cb93", forHTTPHeaderField: "Authorization")
            
            return request
        }
    }
}
