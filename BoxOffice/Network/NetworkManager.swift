//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/21.
//

import Foundation

class NetworkManager {
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchData<T: Decodable>(url: URL?,
                                 type: T.Type,
                                 completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = url else { return }
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
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
            
            guard let data = data,
                  let dataStructure = try? FileDecoder().decodeData(data, type: type).get() else {
                completion(.failure(NetworkingError.dataNotFound))
                
                return
            }
            
            completion(.success(dataStructure))
        }
        task.resume()
    }
}
