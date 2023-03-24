//
//  KobisAPI.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/22.
//

import UIKit

enum KobisAPI {
    case dailyBoxOffice
    case movieDetails
    
    var baseURL: String {
        switch self {
        case .dailyBoxOffice:
            return "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        case .movieDetails:
            return "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
        }
    }
    
    var queryParameters: String {
        switch self {
        case .dailyBoxOffice:
            return "?key=d975f8608af0d9e5a16e79768ca97127&targetDt=20230101"
        case .movieDetails:
            return "?key=d975f8608af0d9e5a16e79768ca97127&movieCd=20199882"
        }
    }
    
    var url: URL? {
        guard let url = URL(string: self.baseURL + self.queryParameters) else { return nil }
        return url
    }
    
    var sampleData: Data {
        switch self {
        case .dailyBoxOffice:
            let sampleData = NSDataAsset(name: "DailyBoxOffice")!.data
            return sampleData
        case .movieDetails:
            let sampleData = NSDataAsset(name: "ThePolicemansLineage")!.data
            return sampleData
        }
    }
}
