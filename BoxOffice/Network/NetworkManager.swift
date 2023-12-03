//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Toy, Morgan on 11/29/23.
//

import Foundation

struct NetworkManager {
    enum DateFormat {
        static var yyyyMMdd = "yyyyMMdd"
    }
    
    func fetchMovie(complitionHandler: @escaping (BoxOffice?) -> Void) {
        let urlString = "\(MovieURL.kobisURL)key=\(Key.key)&targetDt=\(fetchTodayDate())"
        
        executeRequest(with: urlString) { data in
            guard let data = data else { return }
            let safeData = DataDecoder.parseJson(type: BoxOffice.self, data: data)
            complitionHandler(safeData)
        }
    }
    
    func fetchMovieInformation(movieCode: String, complitionHandler: @escaping (Movie?) -> Void) {
        let urlString = "\(MovieURL.detailURL)key=\(Key.key)&movieCd=\(movieCode)"
        
        executeRequest(with: urlString) { data in
            guard let data = data else { return }
            let safeData = DataDecoder.parseJson(type: Movie.self, data: data)
            complitionHandler(safeData)
        }
    }
    
    private func fetchTodayDate() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.yyyyMMdd
        
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: currentDate) else { return .emptyString }
        
        let targetDate = dateFormatter.string(from: yesterday)
        
        return targetDate
    }
    
    private func executeRequest(with urlString: String, complitionHandler: @escaping (Data?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let urlSession = URLSession(configuration: .default)
        
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                return
            }

            guard let data = data else {
                complitionHandler(nil)
                return
            }
            
            complitionHandler(data)
        }
        task.resume()
    }
    
    func parseJson<T: Decodable>(type: T.Type, data: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            let receivedData = try decoder.decode(type, from: data)
            return receivedData
        } catch let error as DecodingError {
            print(error.errorDescription ?? .emptyString)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
