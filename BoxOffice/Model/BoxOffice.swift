//
//  BoxOffice.swift
//  BoxOffice
//
//  Created by Morgan, Toy on 11/28/23.
//

struct BoxOffice: Decodable {
    let boxOffice: Result
}

extension BoxOffice {
    struct Result: Decodable {
        let boxofficeType: String
        let showRange: String
        let dailyBoxOfficeList: [DailyBoxOfficeItem]
    }
}
