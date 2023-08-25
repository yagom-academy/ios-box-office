//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/07/27.
//

import UIKit

struct NetworkManager {
    func fetchData(url: URL?, completion: @escaping (Result<Data?, NetworkError>) -> Void) {
        guard let url = url else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(NetworkError.requestFailed))

                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
    
    func fetchData(urlRequest: URLRequest?, completion: @escaping (Result<Data?, NetworkError>) -> Void) {
        guard let urlRequest = urlRequest else { return }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                completion(.failure(NetworkError.requestFailed))

                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
    
    func fetchImage(url: URL?, completion: @escaping (Result<UIImage?, NetworkError>) -> Void) {
        fetchData(url: url) { result in
            switch result {
            case .success(let data):
                guard let data = data,
                      let image = UIImage(data: data) else { return }
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
