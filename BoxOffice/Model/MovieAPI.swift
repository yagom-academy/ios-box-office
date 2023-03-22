//
//  A.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/03/21.
//

import Foundation

enum MovieAPI {
    
    case boxOffice(date: String)
    case detail(code: String)
    
}

extension MovieAPI {
    
    var key: String {
      return "5946533a51615e4910d26ed447f2a666"
    }
    
    var baseURL: String {
        return "http://kobis.or.kr"
    }
    
    var path: String {
        switch self {
        case .boxOffice:
            return "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        case .detail:
            return "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
        }
    }
    
    var method: String {
        switch self {
        case .boxOffice:
            return HTTPMethod.get
        case .detail:
            return HTTPMethod.get
        }
    }
    
    var parameter: [String: String] {
        switch self {
        case .boxOffice(let date):
            return ["targetDt": date]
        case .detail(let code):
            return ["movieCd": code]
        }
    }
    
}
