//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/21.
//

import Foundation

struct NetworkManager {
    
    func startLoad(urlText: String, complete: @escaping (Data?) -> ()) {
        guard let url = URL(string: urlText) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("response")
                return
            }
            
            let mimeType = response?.mimeType
            
            if ((mimeType?.lowercased().contains("text")) != nil) {
                complete(data)
            }
        }.resume()
    }
}
