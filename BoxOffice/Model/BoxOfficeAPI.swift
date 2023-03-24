//
//  BoxOfficeAPI.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/21.
//

import Foundation

enum BoxOfficeHttpMethod: String {
    case get = "GET"
    case post = "POST"
}

enum BoxOfficeAPI {
    case dailyBoxOffice(date: String)
    case detailMovieInformation(movieCode: String)
}

extension BoxOfficeAPI: API {
    var urlComponents: URLComponents? {
        var components = URLComponents(string: baseURL)
        components?.path = self.path
        
        let apiItem = URLQueryItem(name: "key", value: self.key)
        
        switch self {
        case .dailyBoxOffice(let date):
            let dateItem = URLQueryItem(name: "targetDt", value: date)
            components?.queryItems = [apiItem, dateItem]
        case .detailMovieInformation(let movieCode):
            let movieCodeItem = URLQueryItem(name: "movieCd", value: movieCode)
            components?.queryItems = [apiItem, movieCodeItem]
        }
        
        return components
    }
    
    var baseURL: String {
        return "http://kobis.or.kr/kobisopenapi/webservice/rest/"
    }
    
    var path: String {
        switch self {
        case .dailyBoxOffice:
            return "boxoffice/searchDailyBoxOfficeList.json?"
        case .detailMovieInformation:
            return "movie/searchMovieInfo.json?"
        }
    }
    
    var method: BoxOfficeHttpMethod {
        .get
    }
    
    var key: String {
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

////enum BoxOfficeAPI: Requestable {
////    case dailyBoxOffice(date: String)
////    case detailMovieInformation(movieCode: String)
////
////    private let baseURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/"
////
////    static func makeForEndpoint(_ endpoint: String) -> URL? {
////        guard let url = URL(string: baseURL + endpoint) else {
////            return nil
////        }
////
////        return url
////    }
////
//    static var key: String {
//        get {
//          guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
//            fatalError("Info.plist를 찾지 못했습니다.")
//          }
//
//          let plist = NSDictionary(contentsOfFile: filePath)
//          guard let value = plist?.object(forKey: "API_KEY") as? String else {
//            fatalError("Info.plist에서 API_KEY를 찾을 수 없습니다.")
//          }
//
//          return value
//        }
//    }
//}
////
//extension BoxOfficeAPI {
//    var url: URL? {
//        switch self {
//        case .dailyBoxOffice(let date):
//            let path = "boxoffice/searchDailyBoxOfficeList.json?"
//
//            return BoxOfficeAPI.makeForEndpoint("\(path)key=\(BoxOfficeAPI.key)&targetDt=\(date)")
//        case .detailMovieInformation(let movieCode):
//            let path = "movie/searchMovieInfo.json?"
//
//            return BoxOfficeAPI.makeForEndpoint("\(path)key=\(BoxOfficeAPI.key)&movieCd=\(movieCode)")
//        }
//    }
//}
