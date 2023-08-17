//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by karen on 2023/08/06.
//

import Foundation

struct NetworkManager: NetworkService {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func fetchData(request: URLRequest, completion: @escaping (Result<Data, BoxOfficeError>) -> Void) {
        let task = session.dataTask(with: request) { data, response, error in
            self.handleResponse(data: data, response: response, error: error, completion: completion)
        }
        
        task.resume()
    }
    
    private func handleResponse(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Result<Data, BoxOfficeError>) -> Void) {
        guard error == nil else {
            completion(.failure(.failureRequest))
            return
        }
        
        guard let response = response,
              let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            completion(.failure(.failureReseponse))
            return
        }
        
        guard let data = data else {
            completion(.failure(.invalidDataType))
            return
        }
        
        completion(.success(data))
    }
}
