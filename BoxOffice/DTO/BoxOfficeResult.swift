//
//  BoxOfficeResult.swift
//  BoxOffice
//
//  Created by Serana, BMO on 2023/07/24.
//

struct BoxOfficeResult: Decodable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOffice]
    
    private enum CodingKeys: String, CodingKey {
        case boxofficeType = "boxOfficeType"
        case showRange
        case dailyBoxOfficeList
    }
}
