//
//  BoxOfficeDataLoader.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/04/05.
//

import Foundation

class BoxOfficeDataLoader {
    private let networkManager = NetworkManager()
    
    func loadDailyBoxOffice(completion: @escaping (BoxOffice?, Error?) -> ()) {
        let yesterdayText = DateFormatter.yesterdayText(format: .nonHyphen)
        let endPoint: BoxOfficeEndpoint = .fetchDailyBoxOffice(targetDate: yesterdayText)
        
        networkManager.fetchData(request: endPoint.createRequest(), type: BoxOffice.self) {
            result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    completion(data, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
        }
    }
}
