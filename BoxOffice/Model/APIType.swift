//
//  APIType.swift
//  BoxOffice
//
//  Created by Andrew, 레옹아범 on 2023/03/21.
//
import Foundation

enum APIType {
    case movie(String)
    case boxoffice(String)
    
    func receiveUrl() -> URL? {
        let key = Bundle.main.apiKey
        
        switch self {
        case .movie(let code):
            let movieUrl = URL(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=\(key)&movieCd=\(code)")
            return movieUrl
    
        case .boxoffice(let date):
            let boxofficeUrl = URL(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(key)&targetDt=\(date)")
            return boxofficeUrl
        }
    }
}
