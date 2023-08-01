//
//  KobisOpenAPI.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/07/26.
//

import Foundation

struct KobisOpenAPI {
    let baseURL: URLComponents = {
        var components: URLComponents = URLComponents()
        let queryItem: URLQueryItem = URLQueryItem(name: APIKey.key, value: APIKey.value)
        
        components.scheme = Components.scheme
        components.host = Components.host
        components.path = Components.path
        components.queryItems = [queryItem]
        
        return components
    }()
    
    func receiveURL(serviceType: KobisServiceType, queryItems: [String: String]) -> URL? {
        var components: URLComponents = baseURL
        
        components.path.append(serviceType.urlPath)
        
        queryItems.forEach { item in
            let queryItem: URLQueryItem = URLQueryItem(name: item.key, value: item.value)
            
            components.queryItems?.append(queryItem)
        }
        
        return components.url
    }
    
    private enum APIKey {
        static let key: String = "key"
        static let value: String = "c824c74a1ff9ed62089a9a0bcc0d3211"
    }
    
    private enum Components {
        static let scheme: String = "http"
        static let host: String = "www.kobis.or.kr"
        static let path: String = "/kobisopenapi/webservice/rest"
    }
}

