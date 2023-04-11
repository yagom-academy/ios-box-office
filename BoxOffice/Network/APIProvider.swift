//
//  APIProvider.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/20.
//

import UIKit

struct APIProvider {
    private let endpoint: URLRequestGenerator
    private let urlSession: DataTaskMakeable
    private var api: API?
    
    init(endpoint: URLRequestGenerator = Endpoint(),
         urlSession: DataTaskMakeable = URLSession(configuration: .default),
         api: API? = nil) {
        self.endpoint = endpoint
        self.urlSession = urlSession
        self.api = api
    }
    
    func startLoad<T: Decodable>(decodingType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let api = self.api,
              let request = endpoint.request(for: api) else { return }
        
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
            
            guard let data = data,
                  let decodedData = try? JSONDecoder().decode(decodingType, from: data) else {
                completion(.failure(NetworkError.decoding))
                
                return
            }
            
            completion(.success(decodedData))
        }
        task.resume()
    }
    
    func loadImage(url: URL, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        let urlRequest = URLRequest(url: url)
        let task = urlSession.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.server))
                
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.decoding))
                
                return
            }
            
            completion(.success(UIImage(data: data)))
            
            let cachedURLResponse = CachedURLResponse(response: httpResponse, data: data)
            URLCacheManager.shared.store(response: cachedURLResponse, for: url)
        }
        task.resume()
    }
    
    mutating func target(api: API) {
        self.api = api
    }
}
