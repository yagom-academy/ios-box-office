//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/07/27.
//

import Foundation

class NetworkManager {
    
    typealias NetworkResult = (Result<Data, NetworkError>) -> Void
    
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func fetchData(url: URL, completion: @escaping NetworkResult) {
        let task = session.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.requestFail))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.responseFail))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.statusCodeNotSuccess(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.dataIsNil))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}
