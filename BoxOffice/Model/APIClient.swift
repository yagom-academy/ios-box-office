//
//  APIClient.swift
//  BoxOffice
//
//  Created by Hisop on 2023/11/30.
//

import Foundation

struct APIClient {
    func fetchData(dataType: RequestURL, value: String?, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: dataType.getURL(value: value)) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
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


