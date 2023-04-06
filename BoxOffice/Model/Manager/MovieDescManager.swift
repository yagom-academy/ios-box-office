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
    
    func fetchMoviePosterImage(handler: @escaping (Result<(UIImage, Int, Int), BoxofficeError>) -> Void) {
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
            guard let imageDocument = self.imageDocument else {
                return
            }
            self.fetchImage(imageUrlText: imageDocument.url, width: imageDocument.width, height: imageDocument.height, handler: handler)
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
