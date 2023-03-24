//
//  KobisAPI.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/22.
//

import UIKit

struct KobisAPI {
    enum Service: String {
        case dailyBoxOffice
        case movieDetails
        
        var path: String {
            switch self {
            case .dailyBoxOffice:
                return "boxoffice/searchDailyBoxOfficeList.json"
            case .movieDetails:
                return "movie/searchMovieInfo.json"
            }
        }
        
        var queryName: String {
            switch self {
            case .dailyBoxOffice:
                return "targetDt"
            case .movieDetails:
                return "movieCd"
            }
        }
        
        var sampleData: Data {
            switch self {
            case .dailyBoxOffice:
                let sampleData = NSDataAsset(name: "DailyBoxOffice")!.data
                return sampleData
            case .movieDetails:
                let sampleData = NSDataAsset(name: "ThePolicemansLineage")!.data
                return sampleData
            }
        }
        
        func makeQueryItem(value: String) -> URLQueryItem {
            let queryItem = URLQueryItem(name: self.queryName, value: value)
            return queryItem
        }
    }
    
    var currentService: Service?
    let baseURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/"
    
    init(currentService: Service? = .dailyBoxOffice) {
        self.currentService = currentService
    }
    
    func makeURL(queryValue: String) -> URL? {
        guard let service = currentService else { return nil }
        
        let path = service.path
        let key = URLQueryItem(name: "key", value: "d975f8608af0d9e5a16e79768ca97127")
        let queryItem = URLQueryItem(name: service.queryName, value: queryValue)
        var urlComponents = URLComponents(string: baseURL + path)
        
        urlComponents?.queryItems = [key, queryItem]
        
        return urlComponents?.url
    }
}
