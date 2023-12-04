//
//  URLManager.swift
//  BoxOffice
//
//  Created by jyubong on 12/1/23.
//

enum URLManager {
    case dailyBoxOffice(date: String)
    case movieDetail(code: String)
    
    var url: String {
        let baseURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/"
        let key = "3d65ed918572e0c8dc412bb3bf722f49"
        
        switch self {
        case .dailyBoxOffice(let date):
            return "\(baseURL)boxoffice/searchDailyBoxOfficeList.json?key=\(key)&targetDt=\(date)"
        case .movieDetail(let code):
            return "\(baseURL)movie/searchMovieInfo.json?key=\(key)&movieCd=\(code)"
        }
    }
}
