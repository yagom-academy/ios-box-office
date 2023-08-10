//
//  APIKey.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/07/31.
//

import Foundation

enum APIKey {
    static var boxOffice: String =  {
        return APIKeyFromPlist(key: "BoxOfficeAPIKey")
    }()
    
    static var daumSearch: String = {
        return APIKeyFromPlist(key: "DaumAPIKey")
    }()
}

extension APIKey {
    private static func APIKeyFromPlist(key: String) -> String {
        var apiKey = ""
        
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            let networkKeys = NSDictionary(contentsOfFile: path)
            
            if let networkKeys = networkKeys {
                apiKey = (networkKeys[key] as? String) ?? ""
            }
        }
        
        return apiKey
    }
}
