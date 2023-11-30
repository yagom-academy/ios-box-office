//
//  Namespace.swift
//  BoxOffice
//
//  Created by Hisop on 2023/11/30.
//

import Foundation

enum RequestURL: String {
    case dailyBoxOffice = "boxoffice/searchDailyBoxOfficeList"
    case movieInfo = "movie/searchMovieInfo"
    
    static let myKey = "7d7554c98136c7fcead382ca5f9d5776"
    
    func makeDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        
        return formatter.string(from: Date())
    }
    
    func getURL(movieCode: String?) -> String {
        let searchType: String
        var value: String = ""
        
        switch self {
        case .dailyBoxOffice:
            searchType = self.rawValue
            value = "targetDt=" + makeDate()
        case .movieInfo:
            searchType = self.rawValue
            guard let code = movieCode else {
                break
            }
            value = "movieCd=" + code
        }
        return "http://kobis.or.kr/kobisopenapi/webservice/rest/\(searchType).json?key=\(RequestURL.myKey)&\(value)"
    }
}
