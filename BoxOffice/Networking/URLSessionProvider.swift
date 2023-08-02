//
//  URLSessionProvider.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/07/27.
//

import Foundation

protocol URLSessionProvider {
    func requestData(_ requestURL: URL?, _ completionHandler: @escaping (Result<Data, APIError>) -> Void)
}

final class URLSessionProviderImplementation: URLSessionProvider {
    private var dataTask: URLSessionDataTask?

    func requestData(_ requestURL: URL?, _ completionHandler: @escaping (Result<Data, APIError>) -> Void) {
        guard let requestURL  = requestURL else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        dataTask = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            if error != nil {
                completionHandler(.failure(.requestFail))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299) ~= httpResponse.statusCode else {
                completionHandler(.failure(.invalidHTTPStatusCode))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            completionHandler(.success(data))
        }
        
        self.dataTask?.resume()
    }
}
