//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/07/27.
//

import Foundation

struct NetworkManager {
    func fetchData(url: URL?, completionHandler: @escaping ((Data?, NetworkError?)) -> Void) {
        guard let url = url else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completionHandler((nil, NetworkError.requestFailed))

                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completionHandler((nil, NetworkError.invalidResponse))
                
                return
            }
            
            guard let data = data else {
                completionHandler((nil, NetworkError.noData))
                
                return
            }
            
            completionHandler((data, nil))
        }
        
        task.resume()
    }
}
