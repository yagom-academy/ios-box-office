//
//  BoxOfficeResult.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/20.
//

import Foundation

struct BoxOfficeResult: Codable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeItem]
}
