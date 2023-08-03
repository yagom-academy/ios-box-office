//
//  Service.swift
//  BoxOffice
//
//  Created by redmango, Jusbug on 2023/07/28.
//

import Foundation

enum APIService {
    case dailyBoxOffice
    case movieDetailInfo
    
    var url: URL? {
        switch self {
        case .dailyBoxOffice:
            let key = Bundle.main.apiKey
            let path = "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
            
            return configureURLSession(key: key, path: path)
        case .movieDetailInfo:
            let key = Bundle.main.apiKey
            let path = "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
            
            return configureURLSession(key: key, path: path)
        }
    }
    
    func configureURLSession(key: String, path: String) -> URL? {
        let dateProvider = DateProvider()
        let targetDate = dateProvider.updateYesterday(.urlDate)
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "www.kobis.or.kr"
        urlComponents.path = path
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: key),
            URLQueryItem(name: "targetDt", value: targetDate)
        ]
        
        return urlComponents.url
    }
}
