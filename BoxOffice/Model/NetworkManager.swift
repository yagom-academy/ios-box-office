//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/07/27.
//

import Foundation

struct NetworkManager {
    func fetchData(serviceType: ServiceType) {
        guard let url = APIConstants().receiveURL(serviceType: serviceType) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                return
            }
            
            guard let data = data else {
                return
            }
            
//            switch serviceType {
//            case .dailyBoxOffice:
//                let a = JSONDecoder().decode(data, type: BoxOffice.self)
//                print(a)
//            case .detailInformation:
//                let _ = JSONDecoder().decode(data, type: DetailInformation.self)
//            }
        }
        
        task.resume()
    }
}
