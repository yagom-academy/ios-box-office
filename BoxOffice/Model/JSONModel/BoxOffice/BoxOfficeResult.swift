//
//  BoxOfficeResult.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/27.
//

struct BoxOfficeResult: Decodable {
    let type: String
    let targetDateText: String
    let dailyBoxOfficeList: [DailyBoxOffice]
    
    enum CodingKeys: String, CodingKey {
        case type = "boxofficeType"
        case targetDateText = "showRange"
        case dailyBoxOfficeList
    }
}
