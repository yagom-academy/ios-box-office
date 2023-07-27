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
                if let data = data,
                   let decodedData = try? JSONDecoder().decode(BoxOffice.self, from: data) {
                    print(decodedData)
                }
            case .movieDetailInformation:
                if let data = data,
                   let decodedData = try? JSONDecoder().decode(MovieDetailInformation.self, from: data) {
                    print(decodedData)
                }
            }
        }
        
        task.resume()
    }
}
