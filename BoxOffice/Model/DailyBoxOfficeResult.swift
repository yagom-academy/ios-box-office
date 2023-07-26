//
//  DailyBoxOfficeResult.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/07/25.
//

struct DailyBoxOfficeResult: Decodable {
    let boxOfficeType: String
    let showRange: String
    let dailyBoxOfficeList: [BoxOfficeData]
    
    private enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case showRange
        case dailyBoxOfficeList
    }
}
