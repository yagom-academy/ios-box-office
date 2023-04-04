//
//  MovieDescManager.swift
//  BoxOffice
//
//  Created by 강민수 on 2023/04/03.
//

import UIKit

class MovieDescManager {
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
    
    func fetchMoviePosterImage(handler: @escaping (UIImage?) -> Void) {
        movieImage.fetchData { [weak self] result in
            switch result {
            case .success(let data):
                let urlText = data.documents[0].url
                self?.makeImage(to: urlText, handler: handler)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func makeImage(to urlText: String, handler: @escaping (UIImage?) -> Void) {
        movieImage.fetchImage(imageUrlText: urlText) { result in
            switch result {
            case .success(let image):
                handler(image)
            case .failure(_):
                handler(nil)
            }
        }
    }
}
