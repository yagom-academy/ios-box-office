//
//  MovieService.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/07/27.
//

import Foundation

struct MovieService {
    func fetchData(serviceType: ServiceType) {
        guard let url = APIConstants().receiveURL(serviceType: serviceType) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return
            }
            
            switch serviceType {
            case .dailyBoxOffice:
                let _ = decodeJSON(data: data, type: BoxOffice.self)
            case .detailInformation:
                let _ = decodeJSON(data: data, type: DetailInformation.self)
            }
        }
        
        task.resume()
    }
    
    func decodeJSON<T: Decodable> (data: Data?, type: T.Type) -> T? {
        if let data = data,
           let decodedData = try? JSONDecoder().decode(type, from: data) {
            return decodedData
        }
        
        return nil
    }
}
