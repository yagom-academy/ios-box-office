//
//  APIClient.swift
//  BoxOffice
//
//  Created by Hisop on 2023/11/30.
//

import Foundation

struct APIClient {
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchData<T: Decodable>(serviceType: ServiceType, fileType: FileType = .json, queryItem: [QueryItemName: String] = [:], completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = EndPoint(serviceType: serviceType, type: fileType, queryItem: queryItem).url else {
            return
        }
        
        guard let requestURL = RequestURL(url: url, method: .get, header: ["Accept": "application/json"]).request?.url else {
            return
        }
        
        let task = session.dataTask(with: requestURL) { data, response, error in
            if error != nil {
                completion(.failure(APIError.dataTaskError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(APIError.invalidStatusCode))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(APIError.decodingError))
                return
            }
    
            completion(.success(decodedData))
        }
        
        task.resume()
    }
}


