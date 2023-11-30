//
//  Namespace.swift
//  BoxOffice
//
//  Created by Hisop on 2023/11/30.
//

import Foundation

enum RequestUrl {
    static let myKey = "7d7554c98136c7fcead382ca5f9d5776"
    
    static var dailyBoxOffice: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        
        let today = formatter.string(from: Date())
        
        return "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(myKey)&targetDt=\(today)"
    }
    
    static func movieInfo(movieCode: String) -> String {
        return "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=\(myKey)&movieCd=\(movieCode)"
    }
}
