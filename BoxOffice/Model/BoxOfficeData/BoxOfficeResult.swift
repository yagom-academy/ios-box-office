//
//  BoxOfficeResult.swift
//  BoxOffice
//
//  Created by hoon, mint on 2023/07/24.
//

struct BoxOfficeResult: Decodable {
    let boxOfficeType: String
    let Duration: String
    let dailyBoxOfficeList: [BoxOfficeItem]
    
    enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case Duration = "showRange"
        case dailyBoxOfficeList
    }
}
