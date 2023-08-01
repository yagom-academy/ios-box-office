//
//  KobisOpenAPI.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/07/26.
//

import Foundation

struct KobisOpenAPI {
    var queryItems: [String: String] = [:]
    var serviceType: KobisServiceType
    
    init(serviceType: KobisServiceType) {
        self.serviceType = serviceType
    }
    
    let baseURL: URLComponents = {
        var components = URLComponents()
        let queryItem = URLQueryItem(name: APIKey.key, value: APIKey.value)
        
        components.scheme = Components.scheme
        components.host = Components.host
        components.path = Components.path
        components.queryItems = [queryItem]
        
        return components
    }()
    
    func receiveURL() -> URL? {
        var components = baseURL
        
        components.path.append(serviceType.urlPath)
        
        queryItems.forEach { item in
            let queryItem = URLQueryItem(name: item.key, value: item.value)
            
            components.queryItems?.append(queryItem)
        }
        
        return components.url
    }
    
    mutating func updateQueryItem(key: DailyBoxOfficeQueryKey, value: String)
    {
        queryItems.updateValue(value, forKey: key.description)
    }
    
    mutating func updateQueryItem(key: MovieInformationQueryKey, value: String)
    {
        queryItems.updateValue(value, forKey: key.description)
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
    
    enum DailyBoxOfficeQueryKey: CustomStringConvertible {
        case targetDate
        case itemPerPage
        case multiMovie
        case nationCode
        case areaCode
        
        var description: String {
            switch self {
            case .targetDate:
                return "targetDt"
            case .itemPerPage:
                return "itemPerPage"
            case .multiMovie:
                return "multiMovieYn"
            case .nationCode:
                return "repNationCd"
            case .areaCode:
                return "wideAreaCd"
            }
        }
    }
    
    enum MovieInformationQueryKey: CustomStringConvertible {
        case movieCode
        
        var description: String {
            switch self {
            case .movieCode:
                return "movieCd"
            }
        }
    }
}

