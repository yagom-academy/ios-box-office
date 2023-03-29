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
}

extension BoxOfficeEndPoint {
    var baseURLString: String {
        return "https://www.kobis.or.kr"
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
        }
    }
    
    func createRequest() -> URLRequest? {
        var components = URLComponents(string: baseURLString)
        components?.path = path
        components?.queryItems = queries
        
        guard let url = components?.url else { return nil }
        
        var request = URLRequest(url: url)
        
        return request
    }
}
