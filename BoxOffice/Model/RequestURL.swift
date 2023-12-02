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
    
    func makeDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        
        return formatter.string(from: Date())
    }
    
    func getURL(value: String?) -> String {
        let searchType = self.rawValue
        var target: String = ""
        
        switch self {
        case .dailyBoxOffice:
            guard let value = value else {
                target = "targetDt=" + makeDate()
                break
            }
            
            target = "targetDt=" + value
        case .movieInfo:
            guard let value = value else {
                break
            }
            
            target = "movieCd=" + value
        }
        return "http://kobis.or.kr/kobisopenapi/webservice/rest/\(searchType).json?key=\(MyKey.value)&\(target)"
    }
}
