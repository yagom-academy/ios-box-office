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
    
    func receiveUrl() throws -> URL {
        let key = Bundle.main.apiKey
        
        switch self {
        case .movie(let code):
            guard let movieUrl = URL(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=\(key)&movieCd=\(code)") else {
                throw BoxofficeError.urlError
            }
            return movieUrl
    
        case .boxoffice(let date):
            guard let boxofficeUrl = URL(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(key)&targetDt=\(date)") else {
                throw BoxofficeError.urlError
            }
            return boxofficeUrl
        }
    }
    
}
