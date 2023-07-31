//
//  KobisOpenAPI.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/07/26.
//

import Foundation

struct KobisOpenAPI {
    
        let baseURL: URLComponents = {
        var components = URLComponents()
        let queryItem = URLQueryItem(name: QueryItem.key, value: QueryItem.value)
        
        components.scheme = Components.scheme
        components.host = Components.host
        components.path = Components.path
        components.queryItems = [queryItem]
        
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
    
    private enum QueryItem {
        static let key: String = "key"
        static let value: String = "c824c74a1ff9ed62089a9a0bcc0d3211"
    }

    private enum Components {
        static let scheme: String = "http"
        static let host: String = "www.kobis.or.kr"
        static let path: String = "/kobisopenapi/webservice/rest"
    }
}
