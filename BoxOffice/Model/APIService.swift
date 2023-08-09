//
//  Service.swift
//  BoxOffice
//
//  Created by redmango, Jusbug on 2023/07/28.
//

import Foundation

struct APIService {
    static var shared = APIService()
    var selectedDate: Date?
    
    func configureURLSession(key: String, path: String, targetDate: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.kobis.or.kr"
        urlComponents.path = path
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: key),
        ]
        
        if let targetDate = APIService.shared.selectedDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd"
            let targetDateString = dateFormatter.string(from: targetDate)
            urlComponents.queryItems?.append(URLQueryItem(name: "targetDt", value: targetDateString))
        } else {
            urlComponents.queryItems?.append(URLQueryItem(name: "targetDt", value: targetDate))
        }
        
        return urlComponents.url
    }
}

enum ServiceType {
    case dailyBoxOffice
    case movieDetailInfo
    
    var url: URL? {
        let key = Bundle.main.apiKey
        let apiService = APIService()
        guard let targetDate = DateProvider().updateYesterday(.urlDate) else {
            return nil
        }
        
        switch self {
        case .dailyBoxOffice:
            let path = "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
            return apiService.configureURLSession(key: key, path: path, targetDate: targetDate)
        case .movieDetailInfo:
            let path = "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
            return apiService.configureURLSession(key: key, path: path, targetDate: targetDate)
        }
    }
}

