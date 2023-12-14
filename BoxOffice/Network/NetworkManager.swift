//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Toy, Morgan on 11/29/23.
//

import Foundation

struct NetworkManager {
    func executeRequest<T: Decodable>(endponit: Endpoint, type: T.Type, complitionHandler: @escaping (Result<T, Error>) -> Void) {
        guard let request = try? endponit.asURLGetRequest() else { return }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                complitionHandler(.failure(NetworkManagerError.urlSessionError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                complitionHandler(.failure(NetworkManagerError.responseError))
                return
            }

            guard let data = data else {
                complitionHandler(.failure(NetworkManagerError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let safeData = try decoder.decode(type.self, from: data)
                complitionHandler(.success(safeData))
            } catch {
                complitionHandler(.failure(NetworkManagerError.decodeError))
            }
        }
        task.resume()
    }
    
    func sendRequest<T: Encodable>(endponit: Endpoint, value: T) {
        let encoder = JSONEncoder()
        
        guard let jsonData = try? encoder.encode(value), let request = try? endponit.asURLPostRequset(data: jsonData) else { return }

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print(NetworkManagerError.urlSessionError)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print(NetworkManagerError.responseError)
                return
            }

            guard let data = data else {
                print(NetworkManagerError.invalidData)
                return
            }
            
            print(data)
        }
        task.resume()
    }
}
