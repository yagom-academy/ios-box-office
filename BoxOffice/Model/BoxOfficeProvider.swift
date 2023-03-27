//
//  BoxOfficeProvider.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/24.
//

import Foundation

protocol Requestable {
    associatedtype Target
    func fetchData<T: Decodable>(_ target: Target,
                                 type: T.Type,
                                 completion: @escaping (Result<T, Error>) -> Void)
}

final class BoxOfficeProvider<Target: API>: Requestable {
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchData<T>(_ target: Target,
                      type: T.Type,
                      completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        guard let endPoint = self.makeEndpoint(for: target),
              let request = endPoint.urlRequest() else {
            return
        }
        
        
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(NetworkError.unknownError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            
            guard (200...399).contains(httpResponse.statusCode) else {
                switch httpResponse.statusCode {
                case 400...499:
                    completion(.failure(NetworkError.invalidRequestError))
                case 500...599:
                    completion(.failure(NetworkError.invalidResponseError))
                default:
                    completion(.failure(NetworkError.unknownError))
                }
                
                return
            }
            
            if let data = data {
                do {
                    let jsonData = try JSONDecoder().decode(type, from: data)
                    completion(.success(jsonData))
                } catch {
                    completion(.failure(NetworkError.failToParse))
                }
                
                return
            }
        }
        
        task.resume()
    }
}

extension BoxOfficeProvider {
    func makeEndpoint(for target: API) -> Endpoint? {
        guard let url = target.urlComponents?.url else {
            return nil
        }
        
        return Endpoint(url: url.absoluteString, method: .get)
    }
}
