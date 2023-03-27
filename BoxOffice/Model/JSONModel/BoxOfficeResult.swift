//
//  BoxOfficeResult.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/27.
//

struct BoxOfficeResult: Decodable {
    let boxOfficeType: String
    let targetDateText: String
    let dailyBoxOfficeList: [DailyBoxOffice]
    
    enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case targetDateText = "showRange"
        case dailyBoxOfficeList
    }
}
