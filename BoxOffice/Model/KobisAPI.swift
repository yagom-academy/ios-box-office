//
//  KobisAPI.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/22.
//

import UIKit

struct EndPoint {
    func request(for api: API) -> URLRequest? {
        var urlComponents = URLComponents(string: api.baseURL + api.path)
        urlComponents?.queryItems = []
        
        for (key, value) in api.query {
            let queryItem = URLQueryItem(name: key , value: value)
            
            urlComponents?.queryItems?.append(queryItem)
        }
        
        guard let url = urlComponents?.url else { return nil }
        
        return URLRequest(url: url)
    }
}

protocol API {
    var baseURL: String { get }
    var path: String { get }
    var query: [String: String] { get set }
    var sampleData: Data { get }
    
    func addQuery(name: String, value: String)
}

final class KobisAPI: API {
    var service: KobisService
    var query = ["key": "d975f8608af0d9e5a16e79768ca97127"]
    
    init(service: KobisService) {
        self.service = service
    }
    
    var baseURL: String {
        return "http://www.kobis.or.kr/kobisopenapi/webservice/rest/"
    }
    
    var path: String {
        switch service {
        case .dailyBoxOffice:
            return "boxoffice/searchDailyBoxOfficeList.json"
        case .movieDetails:
            return "movie/searchMovieInfo.json"
        }
    }
    
    var sampleData: Data {
        switch service {
        case .dailyBoxOffice:
            let sampleData = NSDataAsset(name: "DailyBoxOffice")!.data
            return sampleData
        case .movieDetails:
            let sampleData = NSDataAsset(name: "ThePolicemansLineage")!.data
            return sampleData
        }
    }
    
    func addQuery(name: String, value: String) {
        self.query[name] = value
    }
}

enum KobisService {
    case dailyBoxOffice
    case movieDetails
}
