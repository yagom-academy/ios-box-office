//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Kobe, yyss99 on 2023/07/28.
//

import Foundation

struct NetworkManager {
    func makeURLRequest(baseURL: String, queryItems: [URLQueryItem]) throws -> URLRequest {
        guard var baseURL = URL(string: baseURL) else {
            throw MakeURLRequestError.convertURL
        }
        
        baseURL.append(queryItems: queryItems)
        
        let requestURL = URLRequest(url: baseURL)
        
        return requestURL
    }
    
    func getBoxOfficeData(requestURL: URLRequest, sessionConfiguration: URLSessionConfiguration, completionHandler: @escaping (BoxOffice) -> Void) {
        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            guard error == nil else {
                return
            }
            
            let successStatusRange = 200..<300
            guard let response = response as? HTTPURLResponse,
                  successStatusRange.contains(response.statusCode) else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let boxOfficeData = try JSONDecoder().decode(BoxOffice.self, from: data)
                completionHandler(boxOfficeData)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
