//
//  BoxOfficeManager.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/08/01.
//

import Foundation

final class BoxOfficeManager {
    private var boxOffice: BoxOffice? = nil
    private var movie: Movie? = nil
    private let networkManager = NetworkManager(urlSession: URLSession.shared)
    private let kobisKey = Bundle.main.object(forInfoDictionaryKey: NameSpace.kobisKey) as? String
    
    var dailyBoxOfficeDatas: [DailyBoxOfficeData] {
        guard let boxOffice else {
            return []
        }
        
        return DataManager.boxOfficeTransferDailyBoxOfficeData(boxOffice: boxOffice)
    }
    
    var movieInformation: MovieInfo? {
        return movie?.movieInfoResult.movieInfo
    }
    
    func fetchBoxOffice(completion: @escaping (Error?) -> Void) {
        let yesterdayDate = DateFormatter().bringDateString(before: 1, with: DateFormatter.FormatCase.attached)
        let keyItem = URLQueryItem(name: NameSpace.key, value: kobisKey)
        let targetDateItem = URLQueryItem(name: NameSpace.targetDate, value: yesterdayDate)
        let url = URL.makeKobisURL(Path.boxOffice, [keyItem, targetDateItem])
        
        networkManager.getData(from: url) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let boxOffice = try JSONDecoder().decode(BoxOffice.self, from: data)
                    self?.boxOffice = boxOffice
                    completion(nil)
                } catch {
                    completion(DataError.decodeJSONFailed)
                }
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func getMovie(_ movieCode: String, completion: @escaping (Error?) -> Void) {
        let keyItem = URLQueryItem(name: NameSpace.key, value: kobisKey)
        let movieCodeItem = URLQueryItem(name: NameSpace.movieCode, value: movieCode)
        let url = URL.makeKobisURL(Path.movie, [keyItem, movieCodeItem])
        
        networkManager.getData(from: url) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let movie = try JSONDecoder().decode(Movie.self, from: data)
                    self?.movie = movie
                    completion(nil)
                } catch {
                    completion(DataError.decodeJSONFailed)
                }
            case .failure(let error):
                completion(error)
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
