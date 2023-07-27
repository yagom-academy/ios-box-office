//
//  ServiceType.swift
//  BoxOffice
//
//  Created by MARY on 2023/07/27.
//

enum ServiceType {
    case dailyBoxOffice
    case movieDetailInformation
    
    var urlPath: String {
        switch self {
        case .dailyBoxOffice:
            return "/boxoffice/searchDailyBoxOfficeList.json"
        case .movieDetailInformation:
            return "/movie/searchMovieInfo.json"
        }
    }
    
    var type: Any {
        switch self {
        case .dailyBoxOffice:
            return BoxOffice.self
        case .movieDetailInformation:
            return MovieDetailInformation.self
        }
    }
    
    var queryItem: [String: String?] {
        switch self {
        case .dailyBoxOffice:
            return ["targetDt": "20230105",
                    "itemPerPage": nil,
                    "multiMovieYn": nil,
                    "repNationCd": nil,
                    "wideAreaCd": nil]
        case .movieDetailInformation:
            return ["movieCd": nil]
        }
    }
}
