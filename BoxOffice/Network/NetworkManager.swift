//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by 리지, kokkilE on 2023/03/21.
//

import Foundation

class NetworkManager {

    func fetchData<element: Decodable>(_ request: Requestable, returnType: element.Type) {
        let url = URL(string: request.url)!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else { return }
            
            if let mimeType = httpResponse.mimeType, mimeType == "application/json",
               let data = data {
                let result = Decoder.parseJSON(data, returnType: returnType)
            }
        }
        task.resume()
    }
}

