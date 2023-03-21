//
//  DailyBoxoffice.swift
//  BoxOffice
//
//  Created by Andrew, 레옹아범 on 2023/03/21.
//

import Foundation

class DailyBoxoffice {
    let targetDate: String
    var data: DailyBoxofficeObject?
    let apiType = APIType.boxoffice
    
    init(targetDate: String) {
        self.targetDate = targetDate
    }
    
    func search(completion: @escaping (Result<DailyBoxofficeObject, BoxofficeError>) -> Void) {
        do {
            let url = try apiType.getUrl(interfaceValue: targetDate)
            
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
                        let decodingdata = try JSONDecoder().decode(DailyBoxofficeObject.self, from: data)
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
