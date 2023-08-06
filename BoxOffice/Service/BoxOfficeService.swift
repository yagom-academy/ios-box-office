//
//  BoxOfficeService.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/07/30.
//

import Foundation

struct BoxOfficeService {
    private let dateFormatter = DateFormatter()
    
    private var yesterday: Date {
        return Date() - (24 * 60 * 60)
    }
    
    private var formattedYesterday: String {
        dateFormatter.dateFormat = CustomDateFormatStyle.yyyyMMdd
        return dateFormatter.string(from: yesterday)
    }
    
    var formattedYesterdayWithHyphen: String {
        dateFormatter.dateFormat = CustomDateFormatStyle.yyyyMMddWithHyphen
        return dateFormatter.string(from: yesterday)
    }
    
    func loadDailyBoxOfficeData(_ completion: @escaping (Result<BoxOffice, NetworkManagerError>) -> Void) {
        var components = URLComponents()
        components.scheme = KobisNameSpace.scheme
        components.host = KobisNameSpace.host
        components.path = KobisNameSpace.dailyBoxOfficePath
        
        let key = URLQueryItem(name: KobisNameSpace.key,
                               value: KobisNameSpace.keyValue)
        let targetDt = URLQueryItem(name: KobisNameSpace.targetDt,
                                    value: formattedYesterday)
        
        components.queryItems = [key, targetDt]
        
        NetworkManager.loadData(components, BoxOffice.self) { result in
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
        
        let key = URLQueryItem(name: KobisNameSpace.key,
                               value: KobisNameSpace.keyValue)
        let movieCd = URLQueryItem(name: KobisNameSpace.movieCd,
                                   value: movieCd)
        
        components.queryItems = [key, movieCd]
        
        NetworkManager.loadData(components, Movie.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
