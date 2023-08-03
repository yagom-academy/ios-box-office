//
//  BoxOfficeResult.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/07/24.
//

struct BoxOfficeResult: Decodable {
    let boxOfficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOffice]
    
    enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case showRange
        case dailyBoxOfficeList
    }
}


