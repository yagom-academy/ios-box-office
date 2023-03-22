//
//  DailyBoxOfficeURL.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/21.
//

import Foundation

struct DailyBoxOfficeURL: URLAcceptable {
    let url: URL?
    var urlComponents: URLComponents?
    let key: URLQueryItem
    let targetDate: URLQueryItem
    let itemPerPage: URLQueryItem?
    let multiMovieType: URLQueryItem?
    let nationCode: URLQueryItem?
    let wideAreaCode: URLQueryItem?
    
    init(baseURL: String, key: String, targetDate: String, itemPerPage: String? = nil, multiMovieType: MovieType? = nil, nationCode: NationalCode? = nil, wideAreaCode: String? = nil) {
        self.urlComponents = URLComponents(string: baseURL)
        self.key = URLQueryItem(name: "key", value: key)
        self.targetDate = URLQueryItem(name: "targetDt", value: targetDate)
        self.itemPerPage = URLQueryItem(name: "itemPerPage", value: itemPerPage)
        self.multiMovieType = URLQueryItem(name: "multiMovieYn", value: multiMovieType?.sign)
        self.nationCode = URLQueryItem(name: "repNationCd", value: nationCode?.sign)
        self.wideAreaCode = URLQueryItem(name: "wideAreaCd", value: wideAreaCode)
        
        self.urlComponents?.queryItems = [self.key, self.targetDate]
        
        if let itemPerPage = self.itemPerPage {
            self.urlComponents?.queryItems?.append(itemPerPage)
        }
        
        if let multiMovieType = self.multiMovieType {
            self.urlComponents?.queryItems?.append(multiMovieType)
        }
        
        if let nationCode = self.nationCode {
            self.urlComponents?.queryItems?.append(nationCode)
        }

        if let wideAreaCode = self.wideAreaCode {
            self.urlComponents?.queryItems?.append(wideAreaCode)
        }
        
        self.url = self.urlComponents?.url
    }
}
