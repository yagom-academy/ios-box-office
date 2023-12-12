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
    
    func fetchData<T: Decodable>(fileType: FileType, date: String?, completion: @escaping (Result<T, Error>) -> Void) {
        let components = RequestURL.getComponents(type: FileType.json, date: date)
        
        guard let url = components.url else {
            completion(.failure(APIError.componentsError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: url) { data, response, error in
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


