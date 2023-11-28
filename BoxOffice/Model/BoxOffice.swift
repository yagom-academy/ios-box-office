//
//  BoxOffice.swift
//  BoxOffice
//
//  Created by Morgan, Toy on 11/28/23.
//

struct BoxOffice: Decodable, Equatable {
    let boxOfficeResult: BoxOfficeResult
}

extension BoxOffice {
    struct BoxOfficeResult: Decodable, Equatable {
        let boxOfficeType: String
        let showRange: String
        let dailyBoxOfficeList: [DailyBoxOfficeItem]
        
        private enum CodingKeys: String, CodingKey {
            case boxOfficeType = "boxofficeType"
            case showRange
            case dailyBoxOfficeList
        }
    }
}
