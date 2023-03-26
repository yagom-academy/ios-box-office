//
//  URLMaker.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/21.
//

import Foundation

struct URLMaker {
    private let key = "d1fb8a58834af4265bbe3cb487e9a994"
    
    func makeBoxOfficeURL(date: String) -> URL? {
        var components = URLComponents(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json")
        let keyItem = URLQueryItem(name: "key", value: key)
        let targetDateItem = URLQueryItem(name: "targetDt", value: date)
        
        components?.queryItems = [keyItem, targetDateItem]
        
        return components?.url
    }
    
    func makeMovieInformationURL(movieCode: String) -> URL? {
        var components = URLComponents(string: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json")
        let keyItem = URLQueryItem(name: "key", value: key)
        let movieCodeItem = URLQueryItem(name: "movieCd", value: movieCode)
        
        components?.queryItems = [keyItem, movieCodeItem]
        
        return components?.url
    }
}
