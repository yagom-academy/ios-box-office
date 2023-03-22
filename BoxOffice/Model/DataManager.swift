//
//  DataManager.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/20.
//

import UIKit

struct DataManager {
    let kobisUrlSession = URLSession(configuration: .default)
    let urlMaker = URLMaker()
    
    func startLoadDailyBoxOfficeData(date: String, completion: @escaping (Result<DailyBoxOffice, Error>) -> Void) {
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
        let task = kobisUrlSession.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(NetworkError.transport))
                
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.serverResponse))
                
                return
            }
            
            if let mimeType = httpResponse.mimeType,
               mimeType == "application/json",
               let data = data,
               let decodedData = try? JSONDecoder().decode(decodingType, from: data) {
                completion(.success(decodedData))
                
                return
            }
            completion(.failure(NetworkError.decodeFail))
        }
        
        return task
    }
}
