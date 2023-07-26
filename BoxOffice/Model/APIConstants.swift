//
//  APIConstants.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/07/26.
//

import Foundation

struct APIConstants {
    private var targetDate = URLQueryItem(name: "targetDt", value: nil)
    private var itemPerPage = URLQueryItem(name: "itemPerPage", value: nil)
    private var multiMovie = URLQueryItem(name: "multiMovieYn", value: nil)
    private var nationCode = URLQueryItem(name: "repNationCd", value: nil)
    private var wideAreaCode = URLQueryItem(name: "wideAreaCd", value: nil)
    private var movieCode = URLQueryItem(name: "movieCd", value: nil)
    
    private let baseURL: URLComponents = {
        var components = URLComponents()
        let key = URLQueryItem(name: "key", value: "c824c74a1ff9ed62089a9a0bcc0d3211")
        
        components.scheme = "http"
        components.host = "www.kobis.or.kr"
        components.path = "/kobisopenapi/webservice/rest"
        components.queryItems = [key]
        
        return components
    }()
    
    func receiveDailyBoxOfficeURL() -> URL? {
        var components = baseURL
        let queryItems = [targetDate, itemPerPage, multiMovie, nationCode, wideAreaCode]

        components.path.append("/boxoffice/searchDailyBoxOfficeList.json")
        
        queryItems.forEach { queryItem in
            if let _ = queryItem.value {
                components.queryItems?.append(queryItem)
            }
        }
        
        return components.url
    }
    
    func receiveMovieDetailInfomationURL() -> URL? {
        var components = baseURL
        let queryItem = movieCode

        components.path.append("/movie/searchMovieInfo.json")
        
        if let _ = queryItem.value {
            components.queryItems?.append(queryItem)
        }
        
        return components.url
    }
    
    mutating func changeTargetDate(_ targetDate: String?) {
        self.targetDate.value = targetDate
    }
    
    mutating func changeItemPerPage(_ itemPerPage: String?) {
        self.itemPerPage.value = itemPerPage
    }
    
    mutating func changeMultiMovie(_ multiMovie: String?) {
        self.multiMovie.value = multiMovie
    }
    
    mutating func changeNationCode(_ nationCode: String?) {
        self.nationCode.value = nationCode
    }
    
    mutating func changeWideAreaCode(_ wideAreaCode: String?) {
        self.wideAreaCode.value = wideAreaCode
    }
    
    mutating func changeMovieCode(_ movieCode: String?) {
        self.movieCode.value = movieCode
    }
}
