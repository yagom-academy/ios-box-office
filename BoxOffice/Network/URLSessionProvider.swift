//
//  URLSessionProvider.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/03/22.
//

import Foundation

final class URLSessionProvider {
    
    static let shared = URLSessionProvider()
    
    private init() {}
    
    private func dataTask(request: URLRequest, completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, urlResponse, error in
            
            guard error == nil else {
                completionHandler(.failure(.clientError))
                return
            }
            
            guard let response = urlResponse as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completionHandler(.failure(.serverError))
                return
            }
            
            if let data = data {
                return completionHandler(.success(data))
            }
        }
        task.resume()
    }
    
    func performRequest(api: MovieAPI, completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        guard var urlComponents = URLComponents(string: api.baseURL) else {
            completionHandler(.failure(.invalidURLComponents))
            return
        }
        urlComponents.path = api.path
        
        let keyParam = URLQueryItem(name: "key", value: api.key)
        
        var queryParams = api.parameter.map { URLQueryItem(name: $0.key , value: $0.value) }
        queryParams.append(keyParam)
        urlComponents.queryItems = queryParams
        
        guard let url = urlComponents.url else {
            completionHandler(.failure(.invalidURLRequest))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = api.method
        
        dataTask(request: urlRequest, completionHandler: completionHandler)
                
    }
}
