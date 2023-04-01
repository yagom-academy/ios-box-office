//
//  StringEnum.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/03/31.
//

import Foundation

enum Endpoint {
    static let baseURL = "http://kobis.or.kr"
    static let path = "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    static let method = HTTPMethod.self
    static let QueryItemkey = "key"
    static let QueryItemValue = "f5eef3421c602c6cb7ea224104795888"
}

enum queryItem {
    static let DailyBoxOffcieKey = "targetDt"
    static let DailyBoxOffcieValue = "20230330"
    static let MovieDetailKey = "movieCd"
    static let MovieDetailValue = "20230330"
}


