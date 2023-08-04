//
//  BoxOfficeManager.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/08/01.
//

import Foundation

final class BoxOfficeManager {
    private(set) var dailyBoxOfficeDatas: [DailyBoxOfficeData] = []
    private var movie: Movie? = nil
    private let networkManager = NetworkManager(urlSession: URLSession.shared)
    private let kobisKey = Bundle.main.object(forInfoDictionaryKey: NameSpace.kobisKey) as? String
    
    var movieInformation: MovieInfo? {
        return movie?.movieInfoResult.movieInfo
    }
    
    func fetchBoxOffice(completion: @escaping (Bool) -> Void) {
        let yesterdayDate = DateFormatter().bringDateString(before: 1, with: DateFormatter.FormatCase.attached)
        let keyItem = URLQueryItem(name: NameSpace.key, value: kobisKey)
        let targetDateItem = URLQueryItem(name: NameSpace.targetDate, value: yesterdayDate)
        let url = URL.makeKobisURL(Path.boxOffice, [keyItem, targetDateItem])
        
        networkManager.getData(from: url) { [weak self] result in
            guard let self else {
                return
            }
            
            switch result {
            case .success(let data):
                do {
                    let boxOffice = try JSONDecoder().decode(BoxOffice.self, from: data)
                    self.dailyBoxOfficeDatas = DataManager.boxOfficeTransferDailyBoxOfficeData(boxOffice: boxOffice)
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
        let url = URL.makeKobisURL(Path.movie, [keyItem, movieCodeItem])
        
        networkManager.getData(from: url) { [weak self] result in
            guard let self else {
                return
            }
            
            switch result {
            case .success(let data):
                do {
                    let movie = try JSONDecoder().decode(Movie.self, from: data)
                    self.movie = movie
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
private extension BoxOfficeManager {
    enum NameSpace {
        static let kobisKey = "KOBIS_API_KEY"
        static let key = "key"
        static let targetDate = "targetDt"
        static let movieCode = "movieCd"
    }
}
