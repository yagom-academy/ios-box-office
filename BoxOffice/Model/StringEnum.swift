//
//  StringEnum.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/03/31.
//

import Foundation

enum Endpoint {
    static let kobisURL = "http://kobis.or.kr"
    static let kakaoURL = "https://dapi.kakao.com"
    static let kobisPath = "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    static let imageSearchPath = "/v2/search/image"
    static let method = HTTPMethod.self
    
}

enum QueryItem {
    static let queryItemKey = "key"
    static let queryItemValue = "f5eef3421c602c6cb7ea224104795888"
    static let dailyBoxOfficeKey = "targetDt"
    static let dailyBoxOfficeValue = "20230330"
    static let movieDetailKey = "movieCd"
    static let movieDetailValue = "20230330"
}


