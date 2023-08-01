//
//  Bundle+.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/08/01.
//

import Foundation

extension Bundle {
    var KOBIS_API_KEY: String {
        guard let file = self.path(forResource: "KobisAPIKey", ofType: "plist") else { return "" }

        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }

        guard let key = resource["KOBIS_API_KEY"] as? String else {
            fatalError("KOBIS_API_KEY error")
        }
        return key
    }
}
