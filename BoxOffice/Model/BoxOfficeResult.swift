//
//  BoxOfficeResult.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/07/24.
//

struct BoxOfficeResult: Decodable {
    let boxOfficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOffice]

    struct DailyBoxOffice: Decodable {
        
    }
}
