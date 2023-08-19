//
//  DataManager.swift
//  BoxOffice
//
//  Created by karen on 2023/07/28.
//

import UIKit

final class DataManager {
    private let date: Date
    private let boxOfficeManager: BoxOfficeManager<DailyBoxOffice>
    let apiType: APIType
    var movieItems: [BoxOfficeMovieInfo] = []
    
    var navigationTitleText: String {
        return Date.dateFormatter.string(from: date)
    }
    
    init(date: Date) {
        let dataText = Date.apiDateFormatter.string(from: date)
        self.date = date
        self.apiType = APIType.boxOffice(dataText)
        self.boxOfficeManager = BoxOfficeManager<DailyBoxOffice>(apiType: self.apiType, model: NetworkManager(session: .shared))
    }
    
    func fetchRanking(handler: @escaping (Result<[BoxOfficeMovieInfo], Error>) -> Void) {
        boxOfficeManager.fetchData { [weak self] result in
            switch result {
            case .success(let data):
                handler(.success(data.boxOfficeResult.movies))
                self?.movieItems = data.boxOfficeResult.movies
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
}
