//
//  DataLoader.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/04/05.
//

import Foundation

final class DataLoader {
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
    
    func loadMoviePosterURL(movieName: String?,
                            completion: @escaping (URL?, Error?) -> ()) {
        guard let movieName = movieName else { return }
        
        let endPoint: BoxOfficeEndpoint = .fetchMoviePoster(movieName: movieName)
        
        networkManager.fetchData(request: endPoint.createRequest(), type: MoviePoster.self) {
            [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    let url = self?.searchPosterURL(data: data)
                    completion(url, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
        }
    }
    
    private func searchPosterURL(data: MoviePoster) -> URL? {
        guard let firstItem = data.items.first else { return nil }
        
        let urlText = firstItem.imageURLText
        
        return URL(string: urlText)
    }
}
