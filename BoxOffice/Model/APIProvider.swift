//
//  APIProvider.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/20.
//

import UIKit

struct APIProvider {
    private let urlSession: DataTaskMakeable
    private let urlMaker = URLMaker()
    
    init(urlSession: DataTaskMakeable = URLSession(configuration: .default)) {
        self.urlSession = urlSession
    }
    
    func startLoadDailyBoxOffice(date: String, completion: @escaping (Result<DailyBoxOffice, Error>) -> Void) {
        guard let url = urlMaker.makeDailyBoxOfficeURL(date: date) else { return }
        
        let task = makeDataTask(with: url,
                                decodingType: DailyBoxOffice.self,
                                completion: completion)
        task.resume()
    }
    
    func startLoadMovieDetails(code: String, completion: @escaping (Result<MovieDetails, Error>) -> Void) {
        guard let url = urlMaker.makeMovieDetailsURL(code: code) else { return }
        
        let task = makeDataTask(with: url,
                                decodingType: MovieDetails.self,
                                completion: completion)
        task.resume()
    }
    
    private func makeDataTask<T: Decodable>(with url: URL, decodingType: T.Type, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask {
        let task = urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.server))
                
                return
            }
            
            if let data = data,
               let decodedData = try? JSONDecoder().decode(decodingType, from: data) {
                completion(.success(decodedData))
                
                return
            }
            completion(.failure(NetworkError.decoding))
        }
        
        return task
    }
}
