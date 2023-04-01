//
//  URLRequestMaker.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/21.
//

import Foundation

struct URLRequestMaker {
    private let kobisAPIKey = "d1fb8a58834af4265bbe3cb487e9a994"
    private let kakaoAPIKey = "c81ecfbda2df87ff1ed83ba3bd2f6c71"
    
    func makeBoxOfficeURLRequest(date: String) -> URLRequest? {
        var components = URLComponents(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json")
        let keyItem = URLQueryItem(name: "key", value: kobisAPIKey)
        let targetDateItem = URLQueryItem(name: "targetDt", value: date)
        
        components?.queryItems = [keyItem, targetDateItem]
        guard let url = components?.url else { return nil }
        
        let request = URLRequest(url: url)
        
        return request
    }
    
    func makeMovieInformationURLRequest(movieCode: String) -> URLRequest? {
        var components = URLComponents(string: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json")
        let keyItem = URLQueryItem(name: "key", value: kobisAPIKey)
        let movieCodeItem = URLQueryItem(name: "movieCd", value: movieCode)
        
        components?.queryItems = [keyItem, movieCodeItem]
        guard let url = components?.url else { return nil }
        
        let request = URLRequest(url: url)
        
        return request
    }
    
    func makeMoviePosterURLRequest(movieName: String) -> URLRequest? {
        var components = URLComponents(string: "https://dapi.kakao.com/v2/search/image")
        let movieNameForSearch = "\(movieName) 영화포스터"
        let queryItem = URLQueryItem(name: "query", value: movieNameForSearch)
        
        components?.queryItems = [queryItem]
        guard let url = components?.url else { return nil }
        
        var request = URLRequest(url: url)
        request.addValue("KakaoAK \(kakaoAPIKey)", forHTTPHeaderField: "Authorization")
        
        return request
    }
}
