//
//  APIConstants.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/07/26.
//

import Foundation

struct APIConstants {
    private let baseURL: URLComponents = {
        var components = URLComponents()
        let key = URLQueryItem(name: QueryItem.key, value: QueryItem.value)
        
        components.scheme = Components.scheme
        components.host = Components.host
        components.path = Components.path
        components.queryItems = [key]
        
        return components
    }()

    func receiveURL(serviceType: ServiceType) -> URL? {
        var components = baseURL
        
        components.path.append(serviceType.urlPath)
        
        serviceType.queryItem.forEach { item in
            guard let _ = item.value else { return }
            
            let queryItem = URLQueryItem(name: item.key, value: item.value)
            
            components.queryItems?.append(queryItem)
        }
        
        return components.url
    }
}
