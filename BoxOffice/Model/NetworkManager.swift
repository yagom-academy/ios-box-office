//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by jyubong on 11/30/23.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private let key = "3d65ed918572e0c8dc412bb3bf722f49"
    
    private init() { }
    
    func fetchData<T: Decodable>(url: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(FetchError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(FetchError.invalidResponse))
                return
            }
            
            guard let data = data, let movie = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(FetchError.invalidData))
                return
            }
            
            completion(.success(movie))
        }.resume()
    }
}
