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
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(NetworkingError.transportError(error)))
                
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse,
               !(200...299).contains(httpResponse.statusCode) {
                switch httpResponse.statusCode {
                case 400...499:
                    completion(.failure(NetworkingError.clientError))
                case 500...599:
                    completion(.failure(NetworkingError.serverError))
                default:
                    completion(.failure(NetworkingError.unknownError))
                }
                
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkingError.dataNotFound))
                
                return
            }
            
            guard let dataStructure = NetworkDecoder().decode(data: data, type: type) else {
                completion(.failure(NetworkingError.decodeFailed))
                
                return
            }
            
            completion(.success(dataStructure))
        }
        task.resume()
    }
}
