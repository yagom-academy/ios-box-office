//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/07/26.
//

import Foundation

struct NetworkManager {
    func configuredURL(scheme: String, host: String, path: String, queryItems: [URLQueryItem]) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        
        return urlComponents.url ?? nil
    }
    
    func startLoad(_ url: URL, completion: @escaping (Data?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200..<300).contains(response.statusCode) else {
                completion(nil)
                return
            }
            
            guard let data else {
                completion(nil)
                return
            }
            
            completion(data)
        }
        
        task.resume()
    }
}
