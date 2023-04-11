//
//  BoxOfficeResult.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/20.
//

struct BoxOfficeResult: Decodable {
    let type: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOffice]
    
    private enum CodingKeys: String, CodingKey {
        case type = "boxofficeType"
        case showRange
        case dailyBoxOfficeList
    }
}
