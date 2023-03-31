//
//  APIProvider.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/03/22.
//

import Foundation

final class APIProvider {
    
    static let shared = APIProvider()
    
    let session: URLSessionable
    
    init(session: URLSessionable = URLSession.shared) {
        self.session = session
    }
    
    private func dataTask(request: URLRequest, completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        let task = session.dataTask(with: request) { data, urlResponse, error in
            
            guard error == nil else {
                completionHandler(.failure(.clientError))
                return
            }
            
            guard let response = urlResponse as? HTTPURLResponse else {
                completionHandler(.failure(.invalidURLRequest))
                return
            }
            
            switch response.statusCode {
            case (200...299):
                if let data = data {
                    completionHandler(.success(data))
                } else {
                    completionHandler(.failure(.missingData))
                }
            case (400...499):
                completionHandler(.failure(.clientError))
            case (500...599):
                completionHandler(.failure(.serverError))
            default:
                completionHandler(.failure(.invalidURLComponents))
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
    
    func performImageRequest(api: ImageAPI, completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        guard var urlComponents = URLComponents(string: api.baseURL) else {
            completionHandler(.failure(.invalidURLComponents))
            return
        }
        urlComponents.path = api.path
        
        let queryParams = api.parameter.map { URLQueryItem(name: $0.key , value: $0.value) }
        urlComponents.queryItems = queryParams
        
        guard let url = urlComponents.url else {
            completionHandler(.failure(.invalidURLRequest))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = api.method
        urlRequest.allHTTPHeaderFields = api.headers
        
        dataTask(request: urlRequest, completionHandler: completionHandler)
    }

}
