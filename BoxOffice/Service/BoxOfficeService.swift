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
        
        let query = [
            KobisNameSpace.key : KobisNameSpace.keyValue,
            KobisNameSpace.targetDt : formattedYesterday
        ]
        
        guard let url = components.url else { return }
        
        NetworkManager.shared.sendGETRequest(url: url, query: query, objectType: BoxOffice.self) { result in
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
        
        guard let url = components.url else { return }
        
        NetworkManager.shared.sendGETRequest(url: url, query: query, objectType: Movie.self) { result in
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
        // TODO: 리터럴 문자열 네임스페이스로 분리
        components.scheme = "https"
        components.host = "dapi.kakao.com"
        components.path = "/v2/search/image"
        
        let query = [
            "query" : movieNm,
            "size" : "1"
        ]
        
        let kakaoKey = Bundle.main.kakaoApiKey
        
        let headers = [
            "Authorization" : kakaoKey
        ]
        
        guard let url = components.url else { return }
        
        NetworkManager.shared.sendGETRequest(url: url, query: query, headers: headers, objectType: DaumSearchMainText<ImageDocument>.self) { result in
            switch result {
            case .success(let data):
                print("성공했습니다. \(data)")
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
