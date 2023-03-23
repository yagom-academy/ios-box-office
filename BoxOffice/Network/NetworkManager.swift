//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/21.
//

import Foundation

struct NetworkManager {
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func startLoad(url: URL, complete: @escaping (Result<Data, NetworkError>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                complete(.failure(.responseError(error: error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                complete(.failure(.invalidResponse))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                complete(.failure(.responseCodeError(code: httpResponse.statusCode)))
                return
            }
            
            let mimeType = response?.mimeType
            
            guard ((mimeType?.lowercased().contains("text")) != nil) else {
                complete(.failure(.invalidMimeType))
                return
            }
            
            guard let validData = data else {
                complete(.failure(.noData))
                return
            }
            
            complete(.success(validData))
        }.resume()
    }
}
