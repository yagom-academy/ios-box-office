//
//  Bundle+.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/08/09.
//

import Foundation

extension Bundle {
    var kakaoAPIKey: String? {
        return fetchPropertyList(domain: "KAKAO")
    }
    
    var kobisAPIKey: String? {
        return fetchPropertyList(domain: "KOBIS")
    }
    
    private func fetchPropertyList(domain: String) -> String? {
        guard let file = self.path(forResource: "APIKey", ofType: "plist") else { return nil }
        
        guard let resource = NSDictionary(contentsOfFile: file) else { return nil }
        guard let key = resource[domain] as? String else { return nil }
        
        return key
    }
}
