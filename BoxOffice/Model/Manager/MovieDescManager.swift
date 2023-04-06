//
//  MovieDescManager.swift
//  BoxOffice
//
//  Created by 강민수 on 2023/04/03.
//

import UIKit

final class MovieDescManager {
    let boxofficeInfo: BoxofficeInfo<MovieInfoObject>
    let movieImage: BoxofficeInfo<MovieImageObject>
    var imageDocument: Document?
    
    init(movieCode: String, movieName: String, session: URLSession = URLSession.shared) {
        let movieApiType = APIType.movie(movieCode)
        let movieImageApiType = APIType.movieImage(movieName)
        
        self.boxofficeInfo = BoxofficeInfo<MovieInfoObject>(apiType: movieApiType, model: NetworkModel(session: session))
        self.movieImage = BoxofficeInfo<MovieImageObject>(apiType: movieImageApiType, model: NetworkModel(session: session))
    }
    
    func fetchMoviePosterImage(handler: @escaping (Result<(UIImage, CGSize), BoxofficeError>) -> Void) {
        let dispatchGroup = DispatchGroup()
    
        dispatchGroup.enter()

        movieImage.fetchData { [weak self] result in
            switch result {
            case .success(let data):
                guard let document = data.documents.first else {
                    return handler(.failure(.imageVaildError))
                }
                self?.imageDocument = document
                dispatchGroup.leave()
            case .failure(let error):
                handler(.failure(error))
            }
        }
    
        dispatchGroup.notify(queue: .global()) {
            guard let document = self.imageDocument else {
                return
            }
            let imageSize = CGSize(width: document.width, height: document.height)
            
            self.fetchImage(imageUrlText: document.url, imageSize: imageSize, handler: handler)
        }
    }
    
    private func fetchImage(imageUrlText: String, imageSize: CGSize, handler: @escaping (Result<(UIImage, CGSize), BoxofficeError>) -> Void) {
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
            
            handler(.success((image, imageSize)))
        } catch {
            handler(.failure(.responseError))
        }
    }
}
