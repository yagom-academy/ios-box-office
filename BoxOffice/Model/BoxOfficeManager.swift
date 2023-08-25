//
//  BoxOfficeManager.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/08/07.
//

import UIKit

final class BoxOfficeManager {
    func fetchBoxOfficeData(with targetDate: TargetDate, completion: @escaping (Result<[BoxOfficeData]?, Error>) -> Void) {
        let networkManager = NetworkManager()
        
        networkManager.fetchData(url: KobisAPI.boxOffice(targetDate: targetDate.formattedWithoutSeparator()).url) { result in
            do {
                guard let data = try result.get() else { return }
                let decodedData = try DecodingManager.decodeJSON(type: BoxOffice.self, data: data)
                let boxOfficeItems = decodedData.boxOfficeResult.dailyBoxOfficeList
                
                completion(.success(boxOfficeItems))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func fetchMovieData(with movieCode: String, completion: @escaping (Result<MovieInformation?, Error>) -> Void) {
        let networkManager = NetworkManager()
        
        networkManager.fetchData(url: KobisAPI.movie(movieCode: movieCode).url) { result in
            do {
                guard let data = try result.get() else { return }
                let decodedData = try DecodingManager.decodeJSON(type: Movie.self, data: data)
                let movieInformation = decodedData.movieInformationResult.movieInformation
                
                completion(.success(movieInformation))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func fetchMovieImageData(with keyword: String, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        let networkManager = NetworkManager()
        var movieImageURLString: String?
        
        networkManager.fetchData(urlRequest: KakaoAPI.image(keyword: keyword).urlRequest) { result in
            do {
                guard let data = try result.get() else { return }
                let decodedData = try DecodingManager.decodeJSON(type: MovieImage.self, data: data)
                let movieImageItems = decodedData.documents
                
                movieImageURLString = movieImageItems.first?.imageURL
                
                guard let movieImageURLString = movieImageURLString,
                      let movieImageURL = URL(string: movieImageURLString) else { return }
                
                networkManager.fetchImage(url: movieImageURL) { result in
                    guard let image = try? result.get() else { return }
                    
                    completion(.success(image))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
}
