//
//  BoxofficeInfo.swift
//  BoxOffice
//
//  Created by Andrew, 레옹아범 on 2023/03/22.
//

import Foundation

class BoxofficeInfo<T: Fetchable> {
    let interfaceValue: String
    let apiType: APIType
    
    init(interfaceValue: String, apiType: APIType) {
        self.interfaceValue = interfaceValue
        self.apiType = apiType
    }
    
    func search(completion: @escaping (Result<T, BoxofficeError>) -> Void) {
        do {
            let url = try apiType.getUrl(interfaceValue: interfaceValue)
            
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
                        let decodingdata = try JSONDecoder().decode(T.self, from: data)
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
