//
//  BoxOfficeManager.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/08/01.
//

import UIKit

final class BoxOfficeManager {
    private(set) var dailyBoxOffices: [DailyBoxOffice] = []
    private(set) var movieInformation: MovieInformation? = nil
    private(set) var posterImage: UIImage? = nil
    private(set) var targetDate: Date = Date.yesterday
    private let networkManager = NetworkManager(urlSession: URLSession.shared)
    private let kobisKey = Bundle.main.object(forInfoDictionaryKey: NameSpace.kobisKey) as? String
    private let kakaoKey = Bundle.main.object(forInfoDictionaryKey: NameSpace.kakaoKey) as? String
    
    func setTargetDate(_ date: Date) {
        targetDate = date
    }
    
    func fetchBoxOffice(completion: @escaping (Bool) -> Void) {
        let date = DateFormatter().dateString(from: targetDate, with: DateFormatter.FormatCase.attached)
        let keyItem = URLQueryItem(name: NameSpace.key, value: kobisKey)
        let targetDateItem = URLQueryItem(name: NameSpace.targetDate, value: date)
        let url = URL.kobisURL(Path.boxOffice, [keyItem, targetDateItem])
        
        networkManager.requestData(from: url) { [weak self] result in
            guard let self else {
                return
            }
            
            switch result {
            case .success(let data):
                do {
                    let boxOffice = try JSONDecoder().decode(BoxOffice.self, from: data)
                    self.dailyBoxOffices = DataManager.boxOfficeTransferDailyBoxOffice(boxOffice: boxOffice)
                    completion(true)
                } catch {
                    print(DataError.decodeJSONFailed.localizedDescription)
                    completion(false)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    func fetchMovie(_ movieCode: String, completion: @escaping (Bool) -> Void) {
        let keyItem = URLQueryItem(name: NameSpace.key, value: kobisKey)
        let movieCodeItem = URLQueryItem(name: NameSpace.movieCode, value: movieCode)
        let url = URL.kobisURL(Path.movie, [keyItem, movieCodeItem])
        
        networkManager.requestData(from: url) { [weak self] result in
            guard let self else {
                return
            }
            
            switch result {
            case .success(let data):
                do {
                    let movie = try JSONDecoder().decode(Movie.self, from: data)
                    self.movieInformation = DataManager.movieTransferMoiveInformation(movie: movie)
                    completion(true)
                } catch {
                    print(DataError.decodeJSONFailed.localizedDescription)
                    completion(false)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    func fetchPosterImage(_ movieName: String, completion: @escaping (Bool) -> Void) {
        if let cacheImage = CacheManager.shared.cacheImage(forKey: movieName) {
            posterImage = cacheImage
            completion(true)
            return
        }
        
        let queryItem = URLQueryItem(name: NameSpace.query, value: String(format: NameSpace.posterFormat, movieName))
        guard let url = URL.kakaoURL(Path.searchImage, [queryItem]) else {
            completion(false)
            return
        }
        
        let urlRequest = URLRequest.kakaoURLRequest(url, kakaoKey)
        
        networkManager.requestData(from: urlRequest) { [weak self] result in
            guard let self else {
                return
            }
            
            switch result {
            case .success(let data):
                do {
                    let posterImageInformation = try JSONDecoder().decode(PosterImageInformation.self, from: data)
                    guard let url = posterImageInformation.documents.first?.imageURL,
                          let url = URL(string: url) else {
                        completion(false)
                        return
                    }
                    
                    let imageData = try Data(contentsOf: url)
                    
                    guard let image = UIImage(data: imageData) else {
                        completion(false)
                        return
                    }
                    
                    CacheManager.shared.setCacheImage(image, forKey: movieName)
                    self.posterImage = image
                    completion(true)
                } catch {
                    print(DataError.decodeJSONFailed.localizedDescription)
                    completion(false)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
}

// MARK: Name Space
extension BoxOfficeManager {
    private enum NameSpace {
        static let kobisKey = "KOBIS_API_KEY"
        static let kakaoKey = "KAKAO_API_KEY"
        static let key = "key"
        static let targetDate = "targetDt"
        static let movieCode = "movieCd"
        static let query = "query"
        static let posterFormat = "%@ 포스터"
    }
}
