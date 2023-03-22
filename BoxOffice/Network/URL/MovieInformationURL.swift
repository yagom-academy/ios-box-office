//
//  MovieInformationURL.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/21.
//

import Foundation

struct MovieInfomationURL: URLAcceptable {
    let url: URL?
    var urlComponents: URLComponents?
    let key: URLQueryItem
    let movieCode: URLQueryItem
    
    init(baseURL: String, key: String, movieCode: String) {
        self.urlComponents = URLComponents(string: baseURL)
        self.key = URLQueryItem(name: "key", value: key)
        self.movieCode = URLQueryItem(name: "movieCd", value: movieCode)
        self.urlComponents?.queryItems = [self.key, self.movieCode]
        self.url = self.urlComponents?.url
    }
}
