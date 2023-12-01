//
//  APIClient.swift
//  BoxOffice
//
//  Created by Hisop on 2023/11/30.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URL,
                  completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void)
    -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }

struct APIClient {
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchData(url: URL, completion: @escaping (Data?) -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return
            }
            if let jsonData = data {
                completion(jsonData)
            }
        }
        task.resume()
    }
}


