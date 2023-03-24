//
//  APIProvider.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/20.
//

import UIKit

struct APIProvider {
    private let urlSession: DataTaskMakeable
    private let api = KobisAPI()
    
    init(urlSession: DataTaskMakeable = URLSession(configuration: .default)) {
        self.urlSession = urlSession
    }
    
    func startLoad<T: Decodable>(decodingType: T.Type, target: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = api.makeURL(queryValue: target) else { return }
        
        let task = urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.server))
                
                return
            }
            
            if let data = data,
               let decodedData = try? JSONDecoder().decode(decodingType, from: data) {
                completion(.success(decodedData))
                
                return
            }
            completion(.failure(NetworkError.decoding))
        }
        
        task.resume()
    }
}
