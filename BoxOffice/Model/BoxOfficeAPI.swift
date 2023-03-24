//
//  MovieAPI.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/03/21.
//

import Foundation

struct BoxOfficeAPI {
    func loadBoxOfficeAPI<T: Decodable>(urlAddress: String, parser: Parser<T>, completion: @escaping (T) -> Void) {
        guard let url = URL(string: urlAddress) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else { return }
            
            guard let httpURLResponse = response as? HTTPURLResponse, (200...299).contains(httpURLResponse.statusCode) else { return }
            
            guard let validData = data, let parsedData = parser.parse(data: validData) else { return }
            completion(parsedData)
        }.resume()
    }
}

