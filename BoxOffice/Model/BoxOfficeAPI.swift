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
    
    static let key: String = "67e99e70400656a77208ca1775261071"
}

extension BoxOfficeAPI {
    var url: URL? {
        switch self {
        case .dailyBoxOffice(let date):
            let path = "boxoffice/searchDailyBoxOfficeList.json?"
            return .makeForEndpoint("\(path)key=\(BoxOfficeAPI.key)&targetDt=\(date)")
        case .detailMovieInformation(let movieCode):
            let path = "movie/searchMovieInfo.json?"
            return .makeForEndpoint("\(path)key=\(BoxOfficeAPI.key)&movieCd=\(movieCode)")
        }
    }
}

private extension URL {
    static let baseURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/"
    
    static func makeForEndpoint(_ endpoint: String) -> URL? {
        guard let url = URL(string: baseURL + endpoint) else {
            return nil
        }
        return url
    }
}
