//
//  NetworkingManager.swift
//  BoxOffice
//
//  Created by Yetti, Maxhyunm on 2023/07/26.
//

import Foundation

struct NetworkingManager {
    let session: URLSessionProtocol
    
    init(_ session: URLSessionProtocol) {
        self.session = session
    }
    
    func load(_ networkType: NetworkConfiguration, completion: @escaping (Result<Data, NetworkingError>) -> Void) {
        guard let urlString = networkType.url, let header = networkType.header else {
            completion(.failure(NetworkingError.invalidAPIKey))
            return
        }
        var urlComponents = URLComponents(string: urlString)
        
        networkType.query.forEach {
            urlComponents?.queryItems = [URLQueryItem(name: $0.name, value: $0.value)]
        }
        
        guard let url = urlComponents?.url else {
            completion(.failure(NetworkingError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)

        header.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.forHTTPHeaderField)
        }

        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(NetworkingError.connectionFailure))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkingError.notHttpUrlResponse))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkingError.invalidResponse(statusCode: httpResponse.statusCode)))
                return
            }
            
            if let rawData = data,
               let string = String(data: rawData, encoding: .utf8),
               let data = string.data(using: .utf8) {
                completion(.success(data))
            }
        }
        task.resume()
    }
}
