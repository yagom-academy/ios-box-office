//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/07/26.
//

import Foundation

struct NetworkManager {
    private let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }
    
    func requestData(from url: URL?, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url else {
            completion(.failure(.invalidURL))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let task = urlSession.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(.networkFailed))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200..<300).contains(response.statusCode) else {
                completion(.failure(.requestFailed))
                return
            }
            
            guard let data else {
                completion(.failure(.dataFailed))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
    
    func requestData(from urlRequest: URLRequest?, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let urlRequest else {
            completion(.failure(.invalidURLRequest))
            return
        }
        
        let task = urlSession.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(.networkFailed))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200..<300).contains(response.statusCode) else {
                completion(.failure(.requestFailed))
                return
            }
            
            guard let data else {
                completion(.failure(.dataFailed))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}
