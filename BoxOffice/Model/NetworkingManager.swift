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
    
    func load(_ urlString: String, completion: @escaping (Result<Data, NetworkingError>) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }

        let task = session.dataTask(with: url) { data, response, error in
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
