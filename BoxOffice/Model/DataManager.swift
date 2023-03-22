//
//  DataManager.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/20.
//

import UIKit

class DataManager {
    var kobisUrlSession = URLSession(configuration: .default)
    var urlMaker = URLMaker()
    
    func startLoadDailyBoxOfficeData(date: String, completion: @escaping (Result<DailyBoxOffice, Error>) -> Void) {
        guard let url = urlMaker.makeDailyBoxOfficeURL(date: date) else { return }
        
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
               let dailyBoxOfficeData = try? JSONDecoder().decode(DailyBoxOffice.self, from: data) {
                completion(.success(dailyBoxOfficeData))
                
                return
            }
            completion(.failure(NetworkError.decodeFail))
        }
        task.resume()
    }
    
    func startLoadMovieDetails(code: String) {
        guard let url = urlMaker.makeMovieDetailsURL(code: code) else { return }
        
        let task = kobisUrlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("서버와 통신에 실패했습니다.")
                return
            }
            
            if let mimeType = httpResponse.mimeType, mimeType == "application/json",
               let data = data {
                DispatchQueue.main.async { [weak self] in
//                    do {
//                        self?.delegate?.movieDetailsData = try self?.parse(from: data, returnType: MovieDetails.self)
//                    } catch {
//                        print(error.localizedDescription)
//                    }
                }
            }
        }
        task.resume()
    }
}
