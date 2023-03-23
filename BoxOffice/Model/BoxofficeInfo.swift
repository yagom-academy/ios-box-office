//
//  BoxofficeInfo.swift
//  BoxOffice
//
//  Created by Andrew, 레옹아범 on 2023/03/22.
//

import Foundation

struct BoxofficeInfo<T: Fetchable> {
    private let apiType: APIType
    
    init(apiType: APIType) {
        self.apiType = apiType
    }
    
    func search(completion: @escaping (Result<T, BoxofficeError>) -> Void) {
        guard let url = apiType.receiveUrl() else {
            completion(.failure(.urlError))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.sessionError))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.responseError))
                return
            }
            if let mimeType = httpResponse.mimeType, mimeType == "application/json",
               let data = data {
                do {
                    let decodingdata = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodingdata))
                } catch {
                    completion(.failure(.decodingError))
                    return
                }
            }
        }
        
        task.resume()
    }
}
