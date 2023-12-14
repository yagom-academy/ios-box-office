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

struct EndPoint {
    var type: FileType?
    var date: String? = nil

    enum Scheme {
        static let https = "https"
    }
    
    enum Host {
        static let kobis = "kobis.or.kr"
    }
    
    enum ServiceType: String {
        case dailyBoxOffice = "/searchDailyBoxOfficeList"
        case movieList = "/searchMovieList"
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
    
    var url: URL {
        var components = URLComponents()
        
        guard let type = type else {
            guard let mockData = URL(string: "mockData") else {
                fatalError("Failed to mockdata from url init")
            }
            return mockData
        }
        
        components.scheme = Scheme.https
        components.host = Host.kobis
        components.path = Path.webService(serviceType: .dailyBoxOffice, fileType: .json).string
        
        let key = URLQueryItem(name: "key", value: MyKey.value)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        
        var value: String
        if let date = date {
            guard let formatValue = formatter.string(for: date) else {
                fatalError("failed to formatter")
            }
            value = formatValue
        } else {
            value = formatter.string(from: Date().yesterday)
        }
        
        let targetDt = URLQueryItem(name: "targetDt", value: value)
        components.queryItems = [key, targetDt]
        //이부분도 파라미터로 딕셔너리 타입을 받아서 반복문 돌며 추가해줄 수 있을 듯.
        
        guard let url = components.url else {
            fatalError("Failed to url from components")
        }
        return url
    }
}
