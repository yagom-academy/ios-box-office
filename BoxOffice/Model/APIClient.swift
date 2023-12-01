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
    
    func fetchData(url: URL, completion: @escaping (Data?, HTTPURLResponse?) -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, nil)
                return
            }
            guard let jsonData = data else {
                completion(nil, httpResponse)
                return
            }
            completion(jsonData, httpResponse)
        }
        task.resume()
    }
}


