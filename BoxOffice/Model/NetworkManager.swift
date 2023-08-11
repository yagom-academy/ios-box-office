//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by karen on 2023/07/26.
//
import Foundation

struct NetworkManager: NetworkService {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func getRequest(url: URL, completion: @escaping (Result<Data, BoxOfficeError>) -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.failureRequest))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.failureReseponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidType))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}
