//
//  Bundle+.swift
//  BoxOffice
//
//  Created by karen on 2023/08/06.
//

import Foundation

extension Bundle {
    var apiKey: String {
        guard let file = path(forResource: "APIKEY", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["KobisAPIKey"] as? String else {
            fatalError("\(BoxOfficeError.invalidAPIKey)")
        }
        
        return key
    }
}
