//
//  BoxOffice.swift
//  BoxOffice
//
//  Created by Morgan, Toy on 11/28/23.
//

struct BoxOffice: Decodable, Equatable {
    let boxOffice: Result
}

extension BoxOffice {
    struct Result: Decodable, Equatable {
        let boxofficeType: String
        let showRange: String
        let dailyBoxOfficeList: [DailyBoxOfficeItem]
    }
}
