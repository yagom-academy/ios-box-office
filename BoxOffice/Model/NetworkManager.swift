//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/20.
//
import Foundation

final class NetworkManager {
    
    func fetchData(for url: String, completion: @escaping (Result<Data, Error>) -> Void) {
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
                completion(.success(data))
            }
        }
    }
}
