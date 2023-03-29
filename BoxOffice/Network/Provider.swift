//
//  Provider.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/03/28.
//

import Foundation

struct Provider {
    func loadBoxOfficeAPI<T: Decodable>(endpoint: EndPoint, parser: Parser<T>, completion: @escaping (T) -> Void) {
        guard let request = endpoint.makeURLRequest() else { return }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else { return }
            
            guard let httpURLResponse = response as? HTTPURLResponse, (200...299).contains(httpURLResponse.statusCode) else { return }
            
            guard let validData = data, let parsedData = parser.parse(data: validData) else { return }
            completion(parsedData)
        }.resume()
    }
}
