//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/21.
//

import Foundation

final class NetworkManager {
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchData<T: Decodable>(url: URL?,
                                 type: T.Type,
                                 completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = url else {
            completion(.failure(NetworkingError.invalidURL))
            
            return
        }
        
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            guard let self else { return }
            
            self.checkError(data, response, error) { result in
                switch result {
                case .success(let data):
                    completion(self.decode(data: data, type: type))
                case .failure(let error):
                    completion(.failure(NetworkingError.transportError(error)))
                }
            }
        }
        
        task.resume()
    }
    
    private func checkError(_ data: Data?,
                            _ response: URLResponse?,
                            _ error: Error?,
                            completion: @escaping (Result<Data, Error>) -> Void) {
        if let error = error {
            completion(.failure(NetworkingError.transportError(error)))
            
            return
        }
        
        if let httpResponse = response as? HTTPURLResponse,
           !(200...299).contains(httpResponse.statusCode) {
            completion(.failure(checkStatus(code: httpResponse.statusCode)))

            return
        }
        
        guard let data = data else {
            completion(.failure(NetworkingError.dataNotFound))
            
            return
        }
        
        completion(.success(data))
    }
    
    private func checkStatus(code: Int) -> NetworkingError {
        switch code {
        case 400...499:
            return NetworkingError.clientError(code)
        case 500...599:
            return NetworkingError.serverError(code)
        default:
            return NetworkingError.unknownError(code)
        }
    }
    
    private func decode<T: Decodable>(data: Data, type: T.Type) -> Result<T, Error> {
        do {
            let result = try JSONDecoder().decode(type, from: data)
            return .success(result)
        } catch {
            return .failure(NetworkingError.decodeFailed)
        }
    }
}
