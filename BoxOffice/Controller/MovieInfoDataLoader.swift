//
//  MovieInfoDataLoader.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/04/05.
//

import UIKit

final class MovieInfoDataLoader {
    private let networkManager = NetworkManager()
    
    func loadMovieInfo(movieCode: String?,
                       completion: @escaping (Movie?, Error?) -> ()) {
        guard let movieCode = movieCode else { return }
        
        let endPoint: BoxOfficeEndpoint = .fetchMovieInfo(movieCode: movieCode)
        
        networkManager.fetchData(request: endPoint.createRequest(), type: Movie.self) {
            result in
            switch result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func loadMoviePosterImage(movieName: String?,
                            completion: @escaping (UIImage?, Error?) -> ()) {
        guard let movieName = movieName else { return }
        
        let endPoint: BoxOfficeEndpoint = .fetchMoviePoster(movieName: movieName)
        
        networkManager.fetchData(request: endPoint.createRequest(), type: MoviePoster.self) {
            [weak self] result in
            switch result {
            case .success(let data):
                let url = self?.searchPosterURL(data: data)
                self?.loadImage(url: url) { image in
                    completion(image, nil)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    private func searchPosterURL(data: MoviePoster) -> URL? {
        guard let firstItem = data.items.first else { return nil }
        
        let urlText = firstItem.imageURLText
        
        return URL(string: urlText)
    }
    
    private func loadImage(url: URL?, completion: @escaping (UIImage?) -> ()) {
        guard let url = url else { return }
        
        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: url) else {
                completion(nil)
                return
            }
            
            guard let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}
