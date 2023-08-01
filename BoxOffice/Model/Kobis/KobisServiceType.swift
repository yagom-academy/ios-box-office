//
//  KobisServiceType.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/07/27.
//

enum KobisServiceType {
    case dailyBoxOffice
    case movieInformation
    
    var urlPath: String {
        switch self {
        case .dailyBoxOffice:
            return "/boxoffice/searchDailyBoxOfficeList.json"
        case .movieInformation:
            return "/movie/searchMovieInfo.json"
        }
    }
}
