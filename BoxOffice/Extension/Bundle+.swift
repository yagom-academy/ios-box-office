//
//  Bundle+.swift
//  BoxOffice
//
//  Created by Kobe, yyss99 on 2023/08/01.
//

import Foundation

extension Bundle {
    var API: String {
        guard let file = self.path(forResource: "API_KEY", ofType: "plist") else { return "" }
        
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        
        guard let apiKEY = resource["key"] as? String else {
            fatalError("API error")
        }
        return apiKEY
    }
}
