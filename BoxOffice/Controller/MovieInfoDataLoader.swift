//
//  MovieInfoDataLoader.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/04/05.
//

import Foundation

final class MovieInfoDataLoader {
    private let networkManager = NetworkManager()
    
    func loadMovieInfo(movieCode: String?,
                       completion: @escaping (Movie?, Error?) -> ()) {
        guard let movieCode = movieCode else { return }
        
        let endPoint: BoxOfficeEndpoint = .fetchMovieInfo(movieCode: movieCode)
        
        networkManager.fetchData(request: endPoint.createRequest(), type: Movie.self) {
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
