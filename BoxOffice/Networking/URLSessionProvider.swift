//
//  URLSessionProvider.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/07/27.
//

import Foundation

final class URLSessionProvider {
    static func requestData<T: Decodable>(_ request: APIRequest, _ completionHandler: @escaping (Result<APIResponse<T>, APIError>) -> Void) {
        guard let requestURL = setUpRequestURL(request.baseURL, request) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: requestURL) { data, response, error in
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
    private static func decodeResponseData<T: Decodable>(_ responseData: Data, _ completionHandler: (Result<APIResponse<T>, APIError>) -> Void) {
        do {
            let jsonDecoder = JSONDecoder()
            let decodingData = try jsonDecoder.decode(T.self, from: responseData)
            
            completionHandler(.success(.init(data: decodingData)))
        } catch {
            completionHandler(.failure(.decodingFail))
        }
    }
    
    private static func setUpRequestURL(_ baseURL: String,_ request: APIRequest) -> URL? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
    
        if let path = request.path {
            urlComponents.path += path
        }
        
        if let queryItems = request.queryItems {
            urlComponents.queryItems = queryItems.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        
        return urlComponents.url
    }
}
