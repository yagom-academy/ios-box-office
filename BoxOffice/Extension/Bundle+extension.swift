//
//  Bundle+extension.swift
//  BoxOffice
//
//  Created by 레옹아범 ,Andrew on 2023/03/21.
//

import Foundation

extension Bundle {
    var koficApiKey: String {
        guard let file = path(forResource: "BoxOfficeInfo", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["KOFICAPIKEY"] as? String else { fatalError("BoxOfficeInfo.plist에 KOFICAPIKEY 설정 값을 확인해주세요") }
        
        return key
    }
    
    var kakaoApiKey: String {
        guard let file = path(forResource: "BoxOfficeInfo", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["KAKAOAPIKEY"] as? String else { fatalError("BoxOfficeInfo.plist에 KAKAOAPIKEY 설정 값을 확인해주세요") }
        
        return key
    }
}
