//
//  BoxOfficeDataLoader.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/04/05.
//

import UIKit

final class BoxOfficeDataLoader {
    private let networkManager = NetworkManager()
    
    func loadDailyBoxOffice(date: Date, completion: @escaping (Result<BoxOffice,Error>) -> ()) {
        let dateText = DateFormatter.nonHyphenText(date: date)
        let endPoint: BoxOfficeEndpoint = .fetchDailyBoxOffice(targetDate: dateText)
        
        networkManager.fetchData(request: endPoint.createRequest(), type: BoxOffice.self) {
            result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
