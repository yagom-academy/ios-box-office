//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/07/27.
//

import Foundation

struct NetworkManager {
    static func loadData<T: Decodable>(_ components: URLComponents?, _ dataType: T.Type, _ completion: @escaping (Result<T, NetworkManagerError>) -> Void) {
        let urlSession = URLSession(configuration: .default)
        
        guard let url = components?.url else {
            completion(.failure(NetworkManagerError.notExistedUrl))
            return
        }
        
        let task = urlSession.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(NetworkManagerError.cannotLoadFromNetwork))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkManagerError.failureHttpResponse))
                return
            }
            
            if let mimeType = httpResponse.mimeType,
               mimeType == MimeType.jsonFormat,
               let data {
                let jsonDecoder = JSONDecoder()
                do {
                    let result: T = try jsonDecoder.decode(T.self, from: data)
                    completion(.success(result))
                } catch let error as JSONDecoderError {
                    print("JSONDecoder 에러 : \(error)")
                    completion(.failure(NetworkManagerError.failureJsonDecode))
                } catch {
                    print("알 수 없는 에러 발생")
                    completion(.failure(NetworkManagerError.unknown))
                }
            }
        }
        
        task.resume()
    }
}
