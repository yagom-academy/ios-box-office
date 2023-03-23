//
//  extensionNetWorkManager.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/22.
//

import Foundation

protocol DailyBoxOfficeProtocol {
    mutating func receiveParameter(baseURL: String, key: String, targetDate: String, itemPerPage: String?, multiMovieType: MovieType?, nationCode: NationalCode?, wideAreaCode: String?)
}

protocol MovieInformationProtocol {
    mutating func receiveParameter(baseURL: String, key: String, movieCode: String?)
}

extension NetworkManager: DailyBoxOfficeProtocol {
    mutating func receiveParameter(baseURL: String, key: String, targetDate: String, itemPerPage: String? = nil, multiMovieType: MovieType? = nil, nationCode: NationalCode? = nil, wideAreaCode: String? = nil) {
        
        guard var urlComponents = URLComponents(string: baseURL) else { return }
        
        let key = URLQueryItem(name: "key", value: key)
        let targetDate = URLQueryItem(name: "targetDt", value: targetDate)
        
        urlComponents.queryItems = [key, targetDate]
        
        if let itemPerPage = itemPerPage {
            let itemPerPageQuery = URLQueryItem(name: "itemPerPage", value: itemPerPage)
            urlComponents.queryItems?.append(itemPerPageQuery)
        }
        
        if let multiMovieType = multiMovieType {
            let multiMovieTypeQuery = URLQueryItem(name: "multiMovieYn", value: multiMovieType.sign)
            urlComponents.queryItems?.append(multiMovieTypeQuery)
        }
        
        if let nationCode = nationCode {
            let nationCodeQuery = URLQueryItem(name: "repNationCd", value: nationCode.sign)
            urlComponents.queryItems?.append(nationCodeQuery)
        }
        
        if let wideAreaCode = wideAreaCode {
            let wideAreaCodeQuery = URLQueryItem(name: "wideAreaCd", value: wideAreaCode)
            urlComponents.queryItems?.append(wideAreaCodeQuery)
        }
        
        guard let url = urlComponents.url else { return }
        
        self.url = .init(url)
    }
}

extension NetworkManager: MovieInformationProtocol {
    mutating func receiveParameter(baseURL: String, key: String, movieCode: String?) {
        guard var urlComponents = URLComponents(string: baseURL) else { return }
        
        let key = URLQueryItem(name: "key", value: key)
        let movieCode = URLQueryItem(name: "movieCd", value: movieCode)
        urlComponents.queryItems = [key, movieCode]
        
        guard let url = urlComponents.url else { return }
        
        self.url = .init(url)
    }
}
