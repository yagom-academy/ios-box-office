//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by 훈민트 on 2023/08/15.
//

import Foundation

struct NetworkManager {
    func fetchData(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.dataTaskFail))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.responseCasting))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidStatus))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}
