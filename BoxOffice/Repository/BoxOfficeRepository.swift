//
//  BoxOfficeRepository.swift
//  BoxOffice
//
//  Created by Hyungmin Lee on 2023/08/01.
//

import Foundation

protocol BoxOfficeRepository {
    func fetchDailyBoxOffice(_ targetDate: String, _ completionHandler: @escaping (Result<BoxOfficeResult, APIError>) -> Void)
    func fetchMovieDetailInformation(_ movieCode: String, _ completionHandler: @escaping (Result<MovieDetailResult, APIError>) -> Void)
}

final class BoxOfficeRepositoryImpl: BoxOfficeRepository {
    private let sessionProvider: URLSessionProvider
    
    init(sessionProvider: URLSessionProvider) {
        self.sessionProvider = sessionProvider
    }
    
    func fetchDailyBoxOffice(_ targetDate: String, _ completionHandler: @escaping (Result<BoxOfficeResult, APIError>) -> Void) {
        let queryItems: [String: Any] = [
            "key": APIKey.boxOffice,
            "targetDt": targetDate
        ]
        
        let requestURL = setUpRequestURL(BaseURL.boxOffice, BoxOfficeURLPath.daily, queryItems)
        
        sessionProvider.requestData(requestURL) { (result: Result<BoxOfficeResult, APIError>) in
            completionHandler(result)
        }
    }
    
    func fetchMovieDetailInformation(_ movieCode: String, _ completionHandler: @escaping (Result<MovieDetailResult, APIError>) -> Void) {
        let queryItems: [String: Any] = [
            "key": APIKey.boxOffice,
            "movieCd": movieCode
        ]
        
        let requestURL = setUpRequestURL(BaseURL.boxOffice, BoxOfficeURLPath.movieDetail, queryItems)
        
        sessionProvider.requestData(requestURL) { (result: Result<MovieDetailResult, APIError>) in
            completionHandler(result)
        }
    }
}

//MARK: - Private
extension BoxOfficeRepositoryImpl {
    private func setUpRequestURL(_ baseURL: String,_ path: String, _ queryItems: [String: Any]) -> URL? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
        
        urlComponents.path += path
        urlComponents.queryItems = queryItems.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        
        return urlComponents.url
    }
}
