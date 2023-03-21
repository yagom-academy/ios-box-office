//
//  MovieInfo.swift
//  BoxOffice
//
//  Created by Andrew, 레옹아범 on 2023/03/21.
//

import Foundation

class MovieInfo {
    let code: String
    var data: MovieInfoObject?
    let apiType = APIType.movie
    
    init(code: String) {
        self.code = code
    }
    
    func search() throws {
        let url = try apiType.getUrl(interfaceValue: code)
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                return
            }
            if let mimeType = httpResponse.mimeType, mimeType == "application/json",
               let data = data {
                do {
                    self?.data = try JSONDecoder().decode(MovieInfoObject.self, from: data)
                } catch {
                    return
                }
            }
        }
        task.resume()
    }
}
