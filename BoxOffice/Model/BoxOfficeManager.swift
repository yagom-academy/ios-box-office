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
    private let kobisKey = Bundle.main.object(forInfoDictionaryKey: "KOBIS_API_KEY") as? String
    
    var dailyBoxOfficeDatas: [DailyBoxOfficeData?] {
        guard let boxOffice else {
            return []
        }
        
        return DataManager.boxOfficeTransferDailyBoxOfficeData(boxOffice: boxOffice)
    }
    
    var movieInformation: MovieInfo? {
        return movie?.movieInfoResult.movieInfo
    }
    
    func fetchBoxOffice(completion: @escaping (Error?) -> Void) {
        let yesterdayDate = FormatManager.bringDateString(before: 1, with: FormatManager.dateFormat)
        let keyItem = URLQueryItem(name: "key", value: kobisKey)
        let targetDateItem = URLQueryItem(name: "targetDt", value: yesterdayDate)
        let url = URL.makeKobisURL(Path.boxOffice, [keyItem, targetDateItem])
        
        networkManager.getData(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    let boxOffice = try JSONDecoder().decode(BoxOffice.self, from: data)
                    self.boxOffice = boxOffice
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
        let keyItem = URLQueryItem(name: "key", value: kobisKey)
        let movieCodeItem = URLQueryItem(name: "movieCd", value: movieCode)
        let url = URL.makeKobisURL(Path.movie, [keyItem, movieCodeItem])
        
        networkManager.getData(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    let movie = try JSONDecoder().decode(Movie.self, from: data)
                    self.movie = movie
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
