//
//  EndPoint.swift
//  BoxOffice
//
//  Created by Hisop on 2023/12/13.
//

import Foundation

enum FileType: String {
    case json
    case xml
}

struct EndPoint {
    var type: FileType?
    var date: String? = nil
}

extension EndPoint {
    var url: URL {
        var components = URLComponents()
        
        guard let type = type else {
            guard let mockData = URL(string: "mockData") else {
                fatalError("Failed to mockdata from url init")
            }
            return mockData
        }
        
        components.scheme = "https"
        components.host = "kobis.or.kr"
        components.path = "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList." + type.rawValue
        
        let key = URLQueryItem(name: "key", value: MyKey.value)
        
        var value: String
        if let date = date {
            value = date
        } else {
            value = Date().yesterday()
        }
        let targetDt = URLQueryItem(name: "targetDt", value: value)
        components.queryItems = [key, targetDt]
        
        guard let url = components.url else {
            fatalError("Failed to url from components")
        }
        return url
    }
}
