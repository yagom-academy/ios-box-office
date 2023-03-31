//
//  URLMaker.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/21.
//

import Foundation

struct URLMaker {
    private let kobisAPIKey = "d1fb8a58834af4265bbe3cb487e9a994"
    private let kakaoAPIKey = "c81ecfbda2df87ff1ed83ba3bd2f6c71"
    
    func makeBoxOfficeURL(date: String) -> URL? {
        var components = URLComponents(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json")
        let keyItem = URLQueryItem(name: "key", value: kobisAPIKey)
        let targetDateItem = URLQueryItem(name: "targetDt", value: date)
        
        components?.queryItems = [keyItem, targetDateItem]
        
        return components?.url
    }
    
    func makeMovieInformationURL(movieCode: String) -> URL? {
        var components = URLComponents(string: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json")
        let keyItem = URLQueryItem(name: "key", value: kobisAPIKey)
        let movieCodeItem = URLQueryItem(name: "movieCd", value: movieCode)
        
        components?.queryItems = [keyItem, movieCodeItem]
        
        return components?.url
    }
    
    func makeMoviePosterURL(movieName: String) -> URL? {
        var components = URLComponents(string: "https://dapi.kakao.com/v2/search/image")
        let keyItem = URLQueryItem(name: "key", value: kakaoAPIKey)
        let movieNameForSearch = "\(movieName) 영화포스터"
    }
}
