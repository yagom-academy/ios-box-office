//
//  KobisAPI.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/22.
//

import UIKit

final class KobisAPI: API {
    var service: KobisService
    var queries = ["key": "d975f8608af0d9e5a16e79768ca97127"]
    
    init(service: KobisService) {
        self.service = service
    }
    
    var baseURL: String {
        return "http://www.kobis.or.kr/kobisopenapi/webservice/rest/"
    }
    
    var path: String {
        switch service {
        case .dailyBoxOffice:
            return "boxoffice/searchDailyBoxOfficeList.json"
        case .movieDetails:
            return "movie/searchMovieInfo.json"
        }
    }
    
    var sampleData: Data {
        switch service {
        case .dailyBoxOffice:
            let sampleData = NSDataAsset(name: "DailyBoxOffice")!.data
            
            return sampleData
        case .movieDetails:
            let sampleData = NSDataAsset(name: "ThePolicemansLineage")!.data
            
            return sampleData
        }
    }
}

enum KobisService {
    case dailyBoxOffice
    case movieDetails
}
