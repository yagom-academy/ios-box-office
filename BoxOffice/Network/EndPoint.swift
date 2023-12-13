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
    private func makeDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        guard let yesterday = yesterday else {
            return ""
        }
        
        return formatter.string(from: yesterday)
    }
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
            value = makeDate()
        }
        let targetDt = URLQueryItem(name: "targetDt", value: value)
        components.queryItems = [key, targetDt]
        
        guard let url = components.url else {
            fatalError("Failed to url from components")
        }
        return url
    }
}
