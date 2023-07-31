//
//  APIKey.swift
//  BoxOffice
//
//  Created by Hyungmin Lee on 2023/07/31.
//

import Foundation

enum APIKey {
    static var boxOffice: String =  {
        var boxOfficeAPIKey = ""
        
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            let networkKeys = NSDictionary(contentsOfFile: path)
            
            if let networkKeys = networkKeys {
                boxOfficeAPIKey = (networkKeys["BoxOfficeAPIKey"] as? String) ?? ""
            }
        }
            
        return boxOfficeAPIKey
    }()
}
