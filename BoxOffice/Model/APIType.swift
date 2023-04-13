//
//  APIType.swift
//  BoxOffice
//
//  Created by Andrew, 레옹아범 on 2023/03/21.
//
import Foundation

enum APIType {
    case movie(String)
    case boxoffice(String)
    case movieImage(String)
    
    var header: String? {
        switch self {
        case .movieImage(_):
            return "KakaoAK \(Bundle.main.kakaoApiKey)"
        default:
            return nil
        }
    }
    
    private var scheme: String {
        switch self {
        case .movie(_), .boxoffice(_):
            return "http"
        case .movieImage(_):
            return "https"
        }
    }
    
    private var host: String {
        switch self {
        case .movie(_), .boxoffice(_):
            return "kobis.or.kr"
        case .movieImage(_):
            return "dapi.kakao.com"
        }
    }
    
    func receiveUrl() -> URL? {
        let key = Bundle.main.koficApiKey
        var urlComponents = URLComponents()
        
        urlComponents.scheme = scheme
        urlComponents.host = host
        
        switch self {
        case .movie(let code):
            urlComponents.path = "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
            
            let keyQuery = URLQueryItem(name: "key", value: key)
            let codeQuery = URLQueryItem(name: "movieCd", value: code)
            
            urlComponents.queryItems = [keyQuery, codeQuery]
            
            return urlComponents.url
        case .boxoffice(let date):
            urlComponents.path = "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    
            let keyQuery = URLQueryItem(name: "key", value: key)
            let dateQuery = URLQueryItem(name: "targetDt", value: date)
    
            urlComponents.queryItems = [keyQuery, dateQuery]
            
            return urlComponents.url
        case .movieImage(let movieName):
            urlComponents.path = "/v2/search/image"
            
            let query = URLQueryItem(name: "query", value: "\(movieName)포스터")
            urlComponents.queryItems = [query]
            
            return urlComponents.url
        }
    }
}
