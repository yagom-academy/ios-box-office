//
//  ServiceType.swift
//  BoxOffice
//
//  Created by MARY on 2023/07/27.
//

enum ServiceType {
    case dailyBoxOffice
    case detailInformation
    
    var urlPath: String {
        switch self {
        case .dailyBoxOffice:
            return "/boxoffice/searchDailyBoxOfficeList.json"
        case .detailInformation:
            return "/movie/searchMovieInfo.json"
        }
    }
    
    var queryItem: [String: String?] {
        switch self {
        case .dailyBoxOffice:
            return ["targetDt": "20230101",
                    "itemPerPage": nil,
                    "multiMovieYn": nil,
                    "repNationCd": nil,
                    "wideAreaCd": nil]
        case .detailInformation:
            return ["movieCd": "20124079"]
        }
    }
}
