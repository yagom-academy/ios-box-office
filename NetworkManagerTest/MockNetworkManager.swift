//
//  MockNetworkManager.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/23.
//

import Foundation
@testable import BoxOffice

struct MockNetworkManager {
    var urlSession: URLSession
    
    func request<element: Decodable>(endPoint: EndPoint, returnType: element.Type, completion: @escaping (Result<element, NetworkError>) -> Void) {
        guard let urlRequest = endPoint.urlRequest else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = urlSession.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                completion(.failure(.unknown))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.httpResponse))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.httpStatusCode(code: httpResponse.statusCode)))
                return
            }
            
            if let data = data {
                guard let result = Decoder.parseJSON(data, returnType: returnType) else {
                    completion(.failure(.decode))
                    return
                }
                completion(.success(result))
            }
        }
        task.resume()
    }
}
