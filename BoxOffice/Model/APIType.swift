//
//  APIType.swift
//  BoxOffice
//
//  Created by Andrew, 레옹아범 on 2023/03/21.
//
import Foundation

enum APIType {
    case movie
    case boxoffice
    
    func receiveUrl(interfaceValue: String) throws -> URL {
        let key = Bundle.main.apiKey
        
        switch self {
        case .movie:
            guard let movieUrl = URL(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=\(key)&movieCd=\(interfaceValue)") else {
                throw BoxofficeError.urlError
            }
            return movieUrl
    
        case .boxoffice:
            guard let boxofficeUrl = URL(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(key)&targetDt=\(interfaceValue)") else {
                throw BoxofficeError.urlError
            }
            return boxofficeUrl
        }
    }
    
}
