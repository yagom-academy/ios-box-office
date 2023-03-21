//
//  URLMaker.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/21.
//

import Foundation

struct URLMaker {
    
    func makeDailyBoxOfficeURL(date: String) -> URL? {
        var urlComponents = URLComponents(string: Services.dailyBoxOffice.urlString)

        let key = URLQueryItem(name: "key", value: "d975f8608af0d9e5a16e79768ca97127")
        let targetDate = URLQueryItem(name: "targetDt", value: date)

        urlComponents?.queryItems = [key, targetDate]

        let url = urlComponents?.url
        
        return url
    }
    
//    func makeMovieDetailsURL(for code: String) -> URL? {
//
//        return URL()
//    }
//
    
    private enum Services {
        case dailyBoxOffice
        case movieDetails
        
        var urlString: String {
            switch self {
            case .dailyBoxOffice:
                return "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
            case .movieDetails:
                return "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
            }
        }
    }
}
