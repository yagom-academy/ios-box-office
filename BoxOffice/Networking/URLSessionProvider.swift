//
//  URLSessionProvider.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/07/27.
//

import Foundation

final class URLSessionProvider {
    static func requestData<T: Decodable>(_ request: APIRequest, _ session: URLSessionProtocol = URLSession.shared , _ completionHandler: @escaping (APIResult<T>) -> Void) {
        guard let baseURL = URL(string: request.baseURL), let requestURL = setUpRequestURL(baseURL, request) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        let dataTask = session.dataTask(with: requestURL) { data, response, error in
            if error != nil {
                completionHandler(.failure(.requestFail))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completionHandler(.failure(.invalidHTTPStatusCode))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            decodeResponseData(data, completionHandler)
        }
        
        dataTask.resume()
    }
}

// MARK: - Private
extension URLSessionProvider {
    private static func decodeResponseData<T: Decodable>(_ responseData: Data, _ completionHandler: (APIResult<T>) -> Void) {
        do {
            let jsonDecoder = JSONDecoder()
            let decodingData = try jsonDecoder.decode(T.self, from: responseData)
            
            completionHandler(.success(.init(data: decodingData)))
        } catch {
            completionHandler(.failure(.decodingFail))
        }
    }
    
    private static func setUpRequestURL(_ baseURL: URL,_ request: APIRequest) -> URL? {
        var urlComponents = URLComponents()
        
        urlComponents.scheme = baseURL.scheme
        urlComponents.host = baseURL.host
        
        if let path = request.path {
            urlComponents.path = path
        }
        
        if let queryItems = request.queryItems {
            urlComponents.queryItems = queryItems.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        
        return urlComponents.url
    }
}
