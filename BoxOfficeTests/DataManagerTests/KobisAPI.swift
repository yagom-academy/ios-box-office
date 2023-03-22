//
//  KobisAPI.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/22.
//

import UIKit

enum KobisAPI {
    case dailyBoxOffice
    
    static let baseURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    static let queryParameters = "?key=d975f8608af0d9e5a16e79768ca97127&targetDt=20230101"
    
    var url: URL? {
        guard let url = URL(string: Self.baseURL + Self.queryParameters) else { return nil }
        return url
    }
    
    var sampleData: Data {
        let sampleData = NSDataAsset(name: "DailyBoxOffice")!.data
        return sampleData
    }
}
