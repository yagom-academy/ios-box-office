//
//  APIProvider.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/20.
//

import UIKit

struct APIProvider {
    private let endPoint: URLRequestGenerator
    private let urlSession: DataTaskMakeable
    private var api: API?
    
    init(endPoint: URLRequestGenerator = Endpoint(),
         urlSession: DataTaskMakeable = URLSession(configuration: .default),
         api: API? = nil) {
        self.endPoint = endPoint
        self.urlSession = urlSession
        self.api = api
    }
    
    func startLoad<T: Decodable>(decodingType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let api = self.api,
              let request = endPoint.request(for: api) else { return }
        
        let task = urlSession.dataTask(with: request) { data, response, error in
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
            print(request)
            completion(.failure(NetworkError.decoding))
        }
        
        task.resume()
    }
    
    mutating func target(api: API) {
        self.api = api
    }
}
