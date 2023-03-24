//
//  BoxOfficeAPI.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/21.
//

import Foundation

enum BoxOfficeAPI {
    case dailyBoxOffice(date: String)
    case detailMovieInformation(movieCode: String)
    
    static let baseURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/"
    
    static func makeForEndpoint(_ endpoint: String) -> URL? {
        guard let url = URL(string: baseURL + endpoint) else {
            return nil
        }
        
        return url
    }
    
    static var key: String {
        get {
          guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
            fatalError("Info.plist를 찾지 못했습니다.")
          }
            
          let plist = NSDictionary(contentsOfFile: filePath)
          guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Info.plist에서 API_KEY를 찾을 수 없습니다.")
          }
            
          return value
        }
    }
}

extension BoxOfficeAPI {
    var url: URL? {
        switch self {
        case .dailyBoxOffice(let date):
            let path = "boxoffice/searchDailyBoxOfficeList.json?"
            
            return BoxOfficeAPI.makeForEndpoint("\(path)key=\(BoxOfficeAPI.key)&targetDt=\(date)")
        case .detailMovieInformation(let movieCode):
            let path = "movie/searchMovieInfo.json?"
            
            return BoxOfficeAPI.makeForEndpoint("\(path)key=\(BoxOfficeAPI.key)&movieCd=\(movieCode)")
        }
    }
}
