//
//  BoxOfficeResult.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/20.
//

import Foundation

struct BoxOfficeResult: Codable {
    let boxOfficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOffice]
}
