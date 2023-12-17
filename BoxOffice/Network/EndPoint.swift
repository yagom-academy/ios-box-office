//
//  EndPoint.swift
//  BoxOffice
//
//  Created by Hisop on 2023/12/13.
//

import Foundation

enum FileType: String {
    case json = ".json"
    case xml = ".xml"
}

enum ServiceType: String {
    case dailyBoxOffice = "/searchDailyBoxOfficeList"
    case movieList = "/searchMovieList"
}

enum QueryItemName: String {
    case key
    case targetDt
}

struct EndPoint {
    private let serviceType: ServiceType
    private let type: FileType
    private let queryItem: [QueryItemName: String]
    
    init(serviceType: ServiceType, type: FileType, queryItem: [QueryItemName : String]) {
        self.serviceType = serviceType
        self.type = type
        self.queryItem = queryItem
    }
    
    enum Scheme {
        static let https = "https"
    }
    
    enum Host {
        static let kobis = "kobis.or.kr"
    }
    
    enum Path {
        case webService(serviceType: ServiceType, fileType: FileType)
        
        var string: String {
            switch self {
            case let .webService(serviceType: service, fileType: file):
                return "/kobisopenapi/webservice/rest/boxoffice" + service.rawValue + file.rawValue
            }
        }
    }
    
    var url: URL? {
        var components = URLComponents()
        
        components.scheme = Scheme.https
        components.host = Host.kobis
        components.path = Path.webService(serviceType: serviceType, fileType: .json).string
        
        let key = URLQueryItem(name: QueryItemName.key.rawValue, value: MyKey.value)
        components.queryItems = [key]
        
        for (name, value) in queryItem {
            let newItem = URLQueryItem(name: name.rawValue, value: value)
            components.queryItems?.append(newItem)
        }

        return components.url
    }
}
