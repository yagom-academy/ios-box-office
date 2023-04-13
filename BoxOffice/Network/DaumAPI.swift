//
//  DaumAPI.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/30.
//

import Foundation

enum DaumAPI {
    case searchImage(movieName: String)
}

extension DaumAPI: Requestable {
    var urlComponents: URLComponents? {
        var components = URLComponents(string: baseURL)
        components?.path = self.path
        
        var queriesItem: [URLQueryItem] = []
        self.queries.sorted(by:<).forEach { queryItem in
            let queryItem = URLQueryItem(name: queryItem.key, value: queryItem.value)
            queriesItem.append(queryItem)
        }
        
        components?.queryItems = queriesItem
        
        return components
    }
    
    var baseURL: String {
        return "https://dapi.kakao.com"
    }
    
    var path: String {
        switch self {
        case .searchImage:
            return "/v2/search/image"
        }
    }
    
    var queries: [String: String] {
        switch self {
        case .searchImage(let movieName):
            return ["query": movieName]
        }
    }
    
    var method: HttpMethod {
        return .get
    }
    
    var key: String {
        get {
          guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
            fatalError("Info.plist를 찾지 못했습니다.")
          }

          let plist = NSDictionary(contentsOfFile: filePath)
          guard let value = plist?.object(forKey: "DAUM_API_KEY") as? String else {
            fatalError("Info.plist에서 DAUM_API_KEY를 찾을 수 없습니다.")
          }

          return value
        }
    }
    
    var headers: [String : String]? {
        return ["Authorization": "KakaoAK \(key)"]
    }
}
