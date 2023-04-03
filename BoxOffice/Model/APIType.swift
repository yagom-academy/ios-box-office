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
            return "KakaoAK \(Bundle.main.kakaoApiKey))"
        }
    }
    
    func receiveUrl() -> URL? {
        let key = Bundle.main.koficApiKey
        
        switch self {
        case .movie(let code):
            let movieUrl = URL(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=\(key)&movieCd=\(code)")
            return movieUrl
            
        case .boxoffice(let date):
            let boxofficeUrl = URL(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(key)&targetDt=\(date)")
            return boxofficeUrl
        
        case .movieImage(let movieName):
            let imageUrl = URL(string: "https://dapi.kakao.com/v2/search/image?query=\(movieName)포스터")
            return imageUrl
        }
    }
}
