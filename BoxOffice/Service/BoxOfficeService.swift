//
//  BoxOfficeService.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/07/30.
//

import Foundation

struct BoxOfficeService {
    func loadDailyBoxOfficeData(_ completion: @escaping (Result<BoxOffice, NetworkManagerError>) -> Void) {
        var components = URLComponents()
        components.scheme = KobisNameSpace.scheme
        components.host = KobisNameSpace.host
        components.path = KobisNameSpace.dailyBoxOfficePath
        
        let query = [
            KobisNameSpace.key : KobisNameSpace.keyValue,
            KobisNameSpace.targetDt : DateManager.formattedDate
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
