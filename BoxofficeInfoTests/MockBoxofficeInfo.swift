//
//  MockBoxofficeInfo.swift
//  BoxOffice
//
//  Created by Andrew, 레옹아범 on 2023/03/22.
//

import Foundation
@testable import BoxOffice

class MockBoxofficeInfo<T: Fetchable> {
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func search(completion: @escaping (Result<T, BoxofficeError>) -> Void) {
        let url = URL(string: "https://www.naver.com")!
        
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.sessionError))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.responseError))
                return
            }
            if let data = data {
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
