//
//  URLSessionProvider.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/07/27.
//

import Foundation

protocol URLSessionProvider {
    func requestData<T: Decodable>(_ requestURL: URL?, _ completionHandler: @escaping (Result<T, APIError>) -> Void)
}

final class URLSessionProviderImpl: URLSessionProvider {
    private var dataTask: URLSessionDataTask?
    private let decoder: JSONDecoder
    
    init(_ decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    func requestData<T: Decodable>(_ requestURL: URL?, _ completionHandler: @escaping (Result<T, APIError>) -> Void) {
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
            
            self.decoder.decodeResponseData(data, completionHandler)
        }
        
        self.dataTask?.resume()
    }
}
