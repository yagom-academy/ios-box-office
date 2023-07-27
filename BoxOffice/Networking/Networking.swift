//
//  Networking.swift
//  BoxOffice
//
//  Created by Hyungmin Lee on 2023/07/27.
//

import Foundation

final class Networking {
    static func dataTask<T: Decodable>(_ request: APIRequest, _ completionHandler: @escaping (APIResult<T>) -> Void) {
        guard let baseURL = URL(string: request.baseURL), let requestURL = setUpRequestURL(baseURL, request) else {
            completionHandler(.fauilure(.invalidURL))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            if error != nil {
                completionHandler(.fauilure(.requestFail))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completionHandler(.fauilure(.invalidHTTPStatusCode))
                return
            }
            
            guard let data = data else {
                completionHandler(.fauilure(.invalidData))
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let decodingData = try jsonDecoder.decode(T.self, from: data)
                
                completionHandler(.success(.init(data: decodingData)))
            } catch {
                guard let error = error as? DecodingError else { return }
                
                print(error)
                completionHandler(.fauilure(.decodingFail))
            }
        }
        
        dataTask.resume()
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
