//
//  URLSessionProvider.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/07/27.
//

import Foundation

protocol URLSessionProvider {
    func requestData(url: URL?, header: [String: String]?,  completionHandler: @escaping (Result<Data, APIError>) -> Void)
}

final class URLSessionProviderImplementation: URLSessionProvider {
    private var dataTask: URLSessionDataTask?
    
    func requestData(url: URL?, header: [String: String]?,  completionHandler: @escaping (Result<Data, APIError>) -> Void) {
        guard let urlRequest  = setUpURLRequest(url: url, header: header) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
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
    
    private func setUpURLRequest(url: URL?, header: [String: String]?) -> URLRequest? {
        guard let url = url else { return nil }
        var urlRequest = URLRequest(url: url)
        
        if let header = header {
            header.forEach { (field, value) in
                urlRequest.addValue(value, forHTTPHeaderField: field)
            }
        }
        
        return urlRequest
    }
}
