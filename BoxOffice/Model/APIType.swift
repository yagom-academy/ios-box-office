//
//  APIType.swift
//  BoxOffice
//
//  Created by Andrew, 레옹아범 on 2023/03/21.
//
import Foundation

enum APIType: Hashable {
    case movie(String)
    case boxoffice(String)
    case movieImage(String)
    
    var header: String {
        switch self {
        case .movie(_), .boxoffice(_):
            return ""
        case .movieImage(_):
            return "KakaoAK \(Bundle.main.kakaoApiKey)"
        }
    }
    
    func receiveUrl() -> URL? {
        let key = Bundle.main.koficApiKey
        
        switch self {
        case .movie(let code):
            var components = URLComponents(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json")
            let keyQuery = URLQueryItem(name: "key", value: key)
            let codeQuery = URLQueryItem(name: "movieCd", value: code)
            components?.queryItems = [keyQuery, codeQuery]
            
            return components?.url
        case .boxoffice(let date):
            var components = URLComponents(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json")
            let keyQuery = URLQueryItem(name: "key", value: key)
            let dateQuery = URLQueryItem(name: "targetDt", value: date)
            components?.queryItems = [keyQuery, dateQuery]
            
            return components?.url
        case .movieImage(let movieName):
            var components  = URLComponents(string: "https://dapi.kakao.com/v2/search/image")
            let query = URLQueryItem(name: "query", value: "\(movieName)포스터")
            components?.queryItems = [query]
            
            return components?.url
        }
    }
}
