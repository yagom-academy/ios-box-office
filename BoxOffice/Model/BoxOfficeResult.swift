//
//  BoxOfficeResult.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/07/24.
//

struct BoxOfficeResult: Decodable {
    let boxOfficeType: String
    let dateRange: String
    let boxOfficeItems: [BoxOfficeItem]
    
    enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case dateRange = "showRange"
        case boxOfficeItems = "dailyBoxOfficeList"
    }
}
