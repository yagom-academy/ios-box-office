//
//  URLManager.swift
//  BoxOffice
//
//  Created by jyubong on 12/1/23.
//

struct URLManager {
    private let baseURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/"
    private let key = "3d65ed918572e0c8dc412bb3bf722f49"
    
    func dailyBoxOfficeURL(date: String) -> String {
        return "\(baseURL)boxoffice/searchDailyBoxOfficeList.json?key=\(key)&targetDt=\(date)"
    }
    
    func movieDetailURL(code: String) -> String {
        return "\(baseURL)movie/searchMovieInfo.json?key=\(key)&movieCd=\(code)"
    }
}
