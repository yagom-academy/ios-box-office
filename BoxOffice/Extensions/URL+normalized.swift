//
//  URL+.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/03/23.
//

import Foundation

extension URL {
    
    var normalizedURL: URL? {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return nil
        }
        
        if let queryItems = components.queryItems {
            components.queryItems = queryItems.sorted { $0.name < $1.name }
        }
        
        return components.url
    }
    
}
