//
//  Bundle+extension.swift
//  BoxOffice
//
//  Created by 레옹아범 ,Andrew on 2023/03/21.
//

import Foundation

extension Bundle {
    var apiKey: String {
        guard let file = path(forResource: "BoxOfficeInfo", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["APIKEY"] as? String else { fatalError("BoxOfficeInfo.plist에 APIKEY 설정 값을 주세요.") }
        
        return key
    }
}
