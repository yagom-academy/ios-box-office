//
//  RankingManager.swift
//  BoxOffice
//
//  Created by 레옹아범 ,Andrew on 2023/03/31.
//

import Foundation

class RankingManager {
    private let date: Date
    private let boxofficeInfo: BoxofficeInfo<DailyBoxofficeObject>
    let apiType: APIType
    var movieItems: [InfoObject] = []
    
    var navigationTitleText: String {
        return Date.dateFormatter.string(from: date)
    }
    
    init(date: Date) {
        let dataText = Date.apiDateFormatter.string(from: date)
        self.date = date
        self.apiType = APIType.boxoffice(dataText)
        self.boxofficeInfo = BoxofficeInfo<DailyBoxofficeObject>(apiType: self.apiType, model: NetworkModel(session: .shared))
    }
    
    func fetchRanking(handler: @escaping (Result<[InfoObject], Error>) -> Void) {
        boxofficeInfo.fetchData { [weak self] result in
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
