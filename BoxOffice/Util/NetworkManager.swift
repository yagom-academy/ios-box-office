//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/07/27.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func performRequest<T: Decodable>(_ request: URLRequest, _ objectType: T.Type, _ completion: @escaping (Result<T, NetworkManagerError>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
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
                    print("알 수 없는 에러 발생 : \(error)")
                    completion(.failure(NetworkManagerError.unknown))
                }
            }
        }.resume()
    }
    
    func sendGETRequest<T: Decodable>(url: URL, query: [String: String]? = nil, headers: [String: String]? = nil, objectType: T.Type, completion: @escaping (Result<T, NetworkManagerError>) -> Void) {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = query?.map { URLQueryItem(name: $0.key, value: $0.value) }

        var request = URLRequest(url: components?.url ?? url)
        request.httpMethod = "GET"
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        performRequest(request, objectType, completion)
    }
}
