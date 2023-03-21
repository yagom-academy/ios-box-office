//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/20.
//
import Foundation

final class NetworkManager {
    
    func fetchData<T: Decodable>(for url: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("local Error: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("server Error Response: \(response)")
                return
            }
            
            if let mimeType = httpResponse.mimeType, mimeType == "application/json",
               let data = data {
                do {
                    let jsonData = try JSONDecoder().decode(type, from: data)
                    completion(.success(jsonData))
                } catch {
                    print(error)
                }
                return
            }
        }
        task.resume()
    }
}
