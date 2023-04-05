//
//  MovieDescManager.swift
//  BoxOffice
//
//  Created by 강민수 on 2023/04/03.
//

import UIKit

final class MovieDescManager {
    let movieApiType: APIType
    let movieImageApiType: APIType
    let boxofficeInfo: BoxofficeInfo<MovieInfoObject>
    let movieImage: BoxofficeInfo<MovieImageObject>
    
    init(movieApiType: APIType, movieImageApiType: APIType, session: URLSession = URLSession.shared) {
        self.movieApiType = movieApiType
        self.movieImageApiType = movieImageApiType
        self.boxofficeInfo = BoxofficeInfo<MovieInfoObject>(apiType: movieApiType, model: NetworkModel(session: session))
        self.movieImage = BoxofficeInfo<MovieImageObject>(apiType: movieImageApiType, model: NetworkModel(session: session))
    }
    
    func fetchMoviePosterImage(handler: @escaping (Result<(UIImage, Int, Int), BoxofficeError>) -> Void) {
        movieImage.fetchData { [weak self] result in
            switch result {
            case .success(let data):
                guard let urlText = data.documents.first else {
                    return handler(.failure(.imageVaildError))
                }
                
                self?.fetchImage(imageUrlText: urlText.url, width: urlText.width, height: urlText.height, handler: handler)
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
    private func fetchImage(imageUrlText: String, width: Int, height: Int, handler: @escaping (Result<(UIImage, Int, Int), BoxofficeError>) -> Void) {
        guard let url = URL(string: imageUrlText) else {
            handler(.failure(.urlError))
            return
        }
        
        do {
            let imageData = try Data(contentsOf: url)
            guard let image = UIImage(data: imageData) else {
                handler(.failure(.decodingError))
                return
            }
            
            handler(.success((image, width, height)))
        } catch {
            handler(.failure(.responseError))
        }
    }
}
