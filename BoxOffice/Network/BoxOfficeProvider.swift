//
//  BoxOfficeProvider.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/24.
//

import Foundation

protocol Provider {
    associatedtype Target
    func fetchData<T: Decodable>(_ target: Target,
                                 type: T.Type,
                                 completion: @escaping (Result<T, Error>) -> Void)
}

final class BoxOfficeProvider<Target: Requestable>: Provider {
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
        
        if let cachedData = URLCache.shared.cachedResponse(for: request) {
            do {
                let decodeData = try JSONDecoder().decode(type, from: cachedData.data)
                completion(.success(decodeData))
            } catch {
                completion(.failure(NetworkError.failToParse))
            }
            return
        } else {
            let task = session.dataTask(with: request) { data, response, error in
                let result = self.checkError(with: data, response, error)
                switch result {
                case .success(let data):
                    do {
                        let cachedResponse = try URLCacheManager.shared.createCachedResponse(
                            response: response,
                            data: data)
                        URLCacheManager.shared.storeCachedResponse(for: cachedResponse, request: request)
                        
                        let decodedData = try JSONDecoder().decode(type, from: data)
                        completion(.success(decodedData))
                    } catch NetworkError.invalidResponseError {
                        completion(.failure(NetworkError.invalidResponseError))
                    } catch {
                        completion(.failure(NetworkError.failToParse))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }
    
    
    func checkError(with data: Data?,
                    _ response: URLResponse?,
                    _ error: Error?
    ) -> Result<Data, Error> {
        if let _ = error {
            return .failure(NetworkError.unknownError)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return .failure(NetworkError.unknownError)
        }
        
        guard (200...399).contains(httpResponse.statusCode) else {
            switch httpResponse.statusCode {
            case 400...499:
                return .failure(NetworkError.invalidRequestError)
            case 500...599:
                return .failure(NetworkError.invalidResponseError)
            default:
                return .failure(NetworkError.unknownError)
            }
        }
        
        guard let data = data else {
            return .failure(NetworkError.unknownError)
        }
        
        return .success(data)
    }
    
}

extension BoxOfficeProvider {
    func makeEndpoint(for target: Requestable) -> Endpoint? {
        guard let url = target.urlComponents?.url else {
            return nil
        }
        
        return Endpoint(url: url.absoluteString, method: .get, headers: target.headers)
    }
}
