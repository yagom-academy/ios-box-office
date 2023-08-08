//
//  NetworkService.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/07/27.
//

import Foundation

final class NetworkService {
    typealias NetworkResult = (Result<Data, NetworkError>) -> Void
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func fetchData(url: URL, completion: @escaping NetworkResult) {
        let task: URLSessionDataTask  = session.dataTask(with: url) { data, response, error in
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
