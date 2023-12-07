//
//  API.swift
//  BoxOffice
//
//  Created by hyunMac on 12/7/23.
//

import Foundation

struct API {
    let schema: String
    let host: String
    let path: String
    
    init(schema: String, host: String, path: String) {
        self.schema = schema
        self.host = host
        self.path = path
    }
    
    func getURL(apikey: String, queryItems: [URLQueryItem]) -> URL? {
        var components = URLComponents()
        components.scheme = schema
        components.host = host
        components.path = path
        components.queryItems = [
        URLQueryItem(name: "key", value: apikey)] + queryItems
        
        return components.url
    }
}
