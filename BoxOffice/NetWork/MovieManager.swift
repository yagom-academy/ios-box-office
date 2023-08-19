//
//  MovieManager.swift
//  BoxOffice
//
//  Created by karen on 2023/08/19.
//

import UIKit

final class MovieManager {
    let boxOfficeInfo: BoxOfficeManager<MovieInfo>
    let movieImage: BoxOfficeManager<MovieImage>
    var imageDocument: Document?

    init(movieCode: String, movieName: String, session: URLSession = URLSession.shared) {
        self.boxOfficeInfo = BoxOfficeManager<MovieInfo>(apiType: .movie(movieCode), model: NetworkManager(session: session))
        self.movieImage = BoxOfficeManager<MovieImage>(apiType: .movieImage(movieName), model: NetworkManager(session: session))
    }

    func fetchMoviePosterImage(handler: @escaping (Result<(UIImage, CGSize), BoxOfficeError>) -> Void) {
        movieImage.fetchData { [weak self] result in
            switch result {
            case .success(let data):
                guard let document = data.documents.first else {
                    handler(.failure(.failedToGetImage))
                    return
                }
                self?.imageDocument = document
                self?.fetchImage(imageUrlText: document.url, imageSize: CGSize(width: document.width, height: document.height), handler: handler)
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }

    private func fetchImage(imageUrlText: String, imageSize: CGSize, handler: @escaping (Result<(UIImage, CGSize), BoxOfficeError>) -> Void) {
        guard let url = URL(string: imageUrlText) else {
            handler(.failure(.invalidURL))
            return
        }

        NetworkManager.shared.fetchImage(from: url, completionHandler: handler)
    }
}
