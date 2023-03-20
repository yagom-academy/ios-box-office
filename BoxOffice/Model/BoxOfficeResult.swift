//
//  BoxOfficeResult.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/20.
//

import Foundation

struct BoxOfficeResult: Codable {
    let boxOfficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeItem]
    
    private enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case showRange, dailyBoxOfficeList
    }
}
