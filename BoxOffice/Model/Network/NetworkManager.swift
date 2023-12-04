//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by jyubong on 11/30/23.
//

import Foundation

struct NetworkManager {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchData(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(FetchError.invalidURL))
            return
        }
        
        urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(FetchError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(FetchError.invalidData))
                return
            }
            
            completion(.success(data))
        }.resume()
    }
}
