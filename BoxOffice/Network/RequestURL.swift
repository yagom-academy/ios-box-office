//
//  Namespace.swift
//  BoxOffice
//
//  Created by Hisop on 2023/11/30.
//

import Foundation



enum RequestURL {
    static let scheme = "https"
    static let host = "kobis.or.kr"
    static let path = "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList."
    
    static func makeDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        
        return formatter.string(from: Date())
    }
    
    static func getComponents(type: FileType, date: String?) -> URLComponents {
        var components = URLComponents()
        
        components.scheme = scheme
        components.host = host
        components.path = path + type.rawValue

        
        
        return components
    }
}
