//
//  BoxOfficeService.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/07/30.
//

import Foundation

struct BoxOfficeService {
    private let dateFormatter = DateFormatter()
    
    var selectedDate: Date = Date() - (24 * 60 * 60)
    
    var year: String {
        dateFormatter.dateFormat = CustomDateFormatStyle.year
        return dateFormatter.string(from: selectedDate)
    }
    
    var month: String {
        dateFormatter.dateFormat = CustomDateFormatStyle.month
        return dateFormatter.string(from: selectedDate)
    }
    
    var day: String {
        dateFormatter.dateFormat = CustomDateFormatStyle.day
        return dateFormatter.string(from: selectedDate)
    }
    
    private var formattedDate: String {
        dateFormatter.dateFormat = CustomDateFormatStyle.yyyyMMdd
        return dateFormatter.string(from: selectedDate)
    }
    
    var formattedDateWithHyphen: String {
        dateFormatter.dateFormat = CustomDateFormatStyle.yyyyMMddWithHyphen
        return dateFormatter.string(from: selectedDate)
    }
    
    func loadDailyBoxOfficeData(_ completion: @escaping (Result<BoxOffice, NetworkManagerError>) -> Void) {
        var components = URLComponents()
        components.scheme = KobisNameSpace.scheme
        components.host = KobisNameSpace.host
        components.path = KobisNameSpace.dailyBoxOfficePath
        
        let query = [
            KobisNameSpace.key : KobisNameSpace.keyValue,
            KobisNameSpace.targetDt : formattedDate
        ]
        
        guard let dailyBoxOfficeURL = components.url else { return }
        
        NetworkManager.shared.sendGETRequest(url: dailyBoxOfficeURL, query: query, objectType: BoxOffice.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadMovieDetailData(movieCd: String, _ completion: @escaping (Result<Movie, NetworkManagerError>) -> Void) {
        var components = URLComponents()
        components.scheme = KobisNameSpace.scheme
        components.host = KobisNameSpace.host
        components.path = KobisNameSpace.detailMovieInfoPath
        
        let query = [
            KobisNameSpace.key : KobisNameSpace.keyValue,
            KobisNameSpace.movieCd : movieCd
        ]
        
        guard let movieDetailURL = components.url else { return }
        
        NetworkManager.shared.sendGETRequest(url: movieDetailURL, query: query, objectType: Movie.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadMoviePoster(movieNm: String, _ completion: @escaping (Result<DaumSearchMainText<ImageDocument>, NetworkManagerError>) -> Void) {
        var components = URLComponents()
        components.scheme = KakaoNameSpace.scheme
        components.host = KakaoNameSpace.host
        components.path = KakaoNameSpace.path
        
        let query = [
            KakaoNameSpace.query : movieNm,
            KakaoNameSpace.size : KakaoNameSpace.one
        ]
        
        let headers = [
            KakaoNameSpace.authorization : KakaoNameSpace.apiKey
        ]
        
        guard let moviePosterURL = components.url else { return }
        
        NetworkManager.shared.sendGETRequest(url: moviePosterURL, query: query, headers: headers, objectType: DaumSearchMainText<ImageDocument>.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
