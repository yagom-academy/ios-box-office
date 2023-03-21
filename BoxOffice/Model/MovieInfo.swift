//
//  MovieInfo.swift
//  BoxOffice
//
//  Created by Andrew, 레옹아범 on 2023/03/21.
//

import Foundation

class MovieInfo {
    let code: String
    let apiType = APIType.movie
    
    init(code: String) {
        self.code = code
    }
    
    func search(completion: @escaping (Result<MovieInfoObject, BoxofficeError>) -> Void) {
        do {
            let url = try apiType.getUrl(interfaceValue: code)
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    completion(.failure(.sessionError))
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                    completion(.failure(.responseError))
                    return
                }
                if let mimeType = httpResponse.mimeType, mimeType == "application/json",
                   let data = data {
                    do {
                        let decodingdata = try JSONDecoder().decode(MovieInfoObject.self, from: data)
                        completion(.success(decodingdata))
                    } catch {
                        completion(.failure(.decodingError))
                        return
                    }
                }
            }
            
            task.resume()
            
        } catch {
            completion(.failure(.urlError))
            return
        }
    }
}
