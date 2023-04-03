//
//  BoxofficeInfo.swift
//  BoxOffice
//
//  Created by Andrew, 레옹아범 on 2023/03/22.
//

import Foundation

struct NetworkModel: NetworkingProtocol {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func search(request: URLRequest, completion: @escaping (Result<Data, BoxofficeError>) -> Void) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(.sessionError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.responseError))
                return
            }
            
            guard let mimeType = httpResponse.mimeType,
                  mimeType == "application/json",
                  let data = data else {
                completion(.failure(.incorrectDataTypeError))
                return
            }
            completion(.success(data))
        }
        
        task.resume()
        
        return task
    }
}
