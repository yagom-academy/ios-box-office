//
//  BoxOfficeResult.swift
//  BoxOffice
//
//  Created by Morgan, Toy on 11/27/23.
//

struct BoxOfficeResult: Decodable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: DailyBoxOfficeList
}
