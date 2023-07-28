//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/07/26.
//

import Foundation

struct NetworkManager {
    var urlSession: URLSessionProtocol
    
    func configuredURL(scheme: String, host: String, path: String, queryItems: [URLQueryItem]) -> Result<URL, NetworkError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            return .failure(NetworkError.invalidURL)
        }
        
        return .success(url)
    }
    
    func startLoad(_ url: URL, completion: @escaping (Result<Data?, NetworkError>) -> Void) {
        let task = urlSession.dataTask(with: url) { data, response, error in
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
