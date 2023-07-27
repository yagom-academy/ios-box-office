//
//  APIConstants.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/07/26.
//

import Foundation

struct APIConstants {
    private var dailyBoxOfficeQueryItem: [String: String?] = ["targetDt": "20230105",
                                                              "itemPerPage": nil,
                                                              "multiMovieYn": nil,
                                                              "repNationCd": nil,
                                                              "wideAreaCd": nil]
    private var movieDetailIntormationQueryItem: [String: String?] = ["movieCd": nil]
    
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

        components.path.append("/boxoffice/searchDailyBoxOfficeList.json")
        
        dailyBoxOfficeQueryItem.forEach { item in
            guard let _ = item.value else { return }

            let queryItem = URLQueryItem(name: item.key, value: item.value)
            
            components.queryItems?.append(queryItem)
        }
        
        return components.url
    }
    
    func receiveMovieDetailInfomationURL() -> URL? {
        var components = baseURL

        components.path.append("/movie/searchMovieInfo.json")
        
        movieDetailIntormationQueryItem.forEach { item in
            guard let _ = item.value else { return }

            let queryItem = URLQueryItem(name: item.key, value: item.value)
            
            components.queryItems?.append(queryItem)
        }
        
        return components.url
    }
}
