//
//  MovieAPI.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/03/21.
//

import Foundation

protocol BoxOfficeAPIDelegate {
    func fetchAPIData<T: Decodable>(data: T)
}

struct BoxOfficeAPI {
  
    var delegate: BoxOfficeAPIDelegate?
    
    func loadBoxOfficeAPI<T: Decodable>(urlAddress: String, parserType: Parser<T>) {
        guard let url = URL(string: urlAddress) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let validData = data else { return }
            guard let parsedData = parserType.Parse(data: validData) else {return}
            delegate?.fetchAPIData(data: parsedData)
            guard let httpURLResponse = response as? HTTPURLResponse, (200...299).contains(httpURLResponse.statusCode) else {
                print("response")
                return
            }
        }.resume()
    }
}

