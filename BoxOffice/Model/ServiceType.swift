//
//  ServiceType.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/07/27.
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
    

}
