//
//  BoxOfficeURLManager.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/22.
//

import Foundation

struct BoxOfficeURLManager {
    private let scheme = "https"
    private let host = "kobis.or.kr"
    private let dailyBoxOfficePath = "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    private let movieInfoPath = "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
    private let key = "561b75157b06468741f6271d76fe4e9a"
    
    func makeBoxOfficeURL(targetDate: String) -> URL? {
        if targetDate.count != 8 { return nil }
        
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = dailyBoxOfficePath
        components.queryItems = [
            URLQueryItem(name: "key", value: key),
            URLQueryItem(name: "targetDt", value: targetDate)
        ]
        
        return components.url
    }
    
    func makeMovieInfoURL(movieCode: String) -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = movieInfoPath
        components.queryItems = [
            URLQueryItem(name: "key", value: key),
            URLQueryItem(name: "movieCd", value: movieCode)
        ]
        
        return components.url
    }
}
