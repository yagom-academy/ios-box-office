//
//  BoxOfficeResult.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/20.
//

struct BoxOfficeResult: Decodable {
    let boxOfficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOffice]
    
    enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case showRange, dailyBoxOfficeList
    }
}
