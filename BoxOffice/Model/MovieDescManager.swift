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
    
    func fetchMoviePosterImage(handler: @escaping (Result<UIImage, BoxofficeError>) -> Void) {
        movieImage.fetchData { [weak self] result in
            switch result {
            case .success(let data):
                let urlText = data.documents[0].url
                self?.fetchImage(imageUrlText: urlText, handler: handler)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchImage(imageUrlText: String, handler: @escaping (Result<UIImage, BoxofficeError>) -> Void) {
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
            
            handler(.success(image))
        } catch {
            handler(.failure(.responseError))
        }
    }
}
