//
//  DailyBoxOfficeURL.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/21.
//

import Foundation

struct DailyBoxOfficeURL: Requestable {
    let url: URL?
    var urlComponents: URLComponents?
    let key: URLQueryItem
    let targetDate: URLQueryItem
    
    init(baseURL: String, key: String, targetDate: String) {
        self.urlComponents = URLComponents(string: baseURL)
        self.key = URLQueryItem(name: "key", value: key)
        self.targetDate = URLQueryItem(name: "targetDt", value: targetDate)
        self.urlComponents?.queryItems = [self.key, self.targetDate]
        self.url = self.urlComponents?.url
    }
}
