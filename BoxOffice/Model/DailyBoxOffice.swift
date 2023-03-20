//
//  DailyBoxOffice.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/20.
//

struct DailyBoxOffice: Decodable {
    let rowNumber: Int
    let rank: Int
    let movieName: String
    let openDate: String
    
    enum CodingKeys: String, CodingKey {
        case rowNumber = "rnum"
        case rank
        case movieName = "movieNm"
        case openDate = "openDt"
    }
}
