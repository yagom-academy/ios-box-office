//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Toy, Morgan on 11/29/23.
//

import Foundation

struct NetworkManager {
    func executeRequest<T: Decodable>(api: API, apiKey: String, queryItems:[URLQueryItem], type: T.Type, complitionHandler: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = api.getURL(apikey: apiKey, queryItems: queryItems) else {
            complitionHandler(.failure(ExecuteRequestError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                complitionHandler(.failure(ExecuteRequestError.urlSessionError))
                return
            }

            guard let data = data else {
                complitionHandler(.failure(ExecuteRequestError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let safeData = try decoder.decode(T.self, from: data)
                complitionHandler(.success(safeData))
            } catch {
                complitionHandler(.failure(ExecuteRequestError.decodeError))
            }
        }
        task.resume()
    }
}
