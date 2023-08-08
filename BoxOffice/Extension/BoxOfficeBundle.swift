//
//  BoxOfficeBundle.swift
//  BoxOffice
//
//  Created by Serena, BMO on 2023/08/08.
//

import Foundation

extension Bundle {
    var kakaoApiKey: String {
        guard let file = self.path(forResource: "KakaoAPIKey", ofType: "plist") else { return "" }
        guard let resource = NSDictionary (contentsOfFile: file) else { return "" }
        guard let key = resource["Authorization"] as? String else {
            fatalError("KakaoAPIKey.plist에 Authorization를 설정해주세요.")
        }
        
        return key
    }
}
