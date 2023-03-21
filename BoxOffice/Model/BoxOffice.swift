//
//  BoxOffice.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/20.
//

struct BoxOffice: Decodable {
    let boxOfficeResult: BoxOfficeResult
    
    struct BoxOfficeResult: Decodable {
        let boxOfficeType: String
        let showingDuration: String
        let dailyBoxOfficeList: [DailyBoxOffice]
        
        enum CodingKeys: String, CodingKey {
            case boxOfficeType = "boxofficeType"
            case showingDuration = "showRange"
            case dailyBoxOfficeList
        }
    }
}
