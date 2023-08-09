//
//  Service.swift
//  BoxOffice
//
//  Created by redmango, Jusbug on 2023/07/28.
//

import Foundation

class URLManager {
    static let shared = URLManager()
    var selectedDate: Date?
    
    private init() {}
    
    func configureURLSession(key: String, path: String, targetDate: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.kobis.or.kr"
        urlComponents.path = path
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: key),
        ]
        
        if let targetDate = URLManager.shared.selectedDate {
            let formattedTargetDate = DateProvider().formatDate(with: targetDate, by: .urlDate)
            urlComponents.queryItems?.append(URLQueryItem(name: "targetDt", value: formattedTargetDate))
        } else {
            urlComponents.queryItems?.append(URLQueryItem(name: "targetDt", value: targetDate))
        }
        
        return urlComponents.url
    }
}

enum APIService {
    case dailyBoxOffice
    case movieDetailInfo
    
    var url: URL? {
        let key = Bundle.main.apiKey
        let urlManager = URLManager.shared
        guard let targetDate = DateProvider().updateDate(to: -1, by: .urlDate) else {
            return nil
        }
        
        switch self {
        case .dailyBoxOffice:
            let path = "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
            return urlManager.configureURLSession(key: key, path: path, targetDate: targetDate)
        case .movieDetailInfo:
            let path = "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
            return urlManager.configureURLSession(key: key, path: path, targetDate: targetDate)
        }
    }
}

