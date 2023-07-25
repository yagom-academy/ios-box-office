//
//  BoxOfficeResult.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/07/24.
//

struct BoxOfficeResult: Decodable {
    let daily: DailyBoxOffice
    
    private enum CodingKeys: String, CodingKey {
        case daily = "boxOfficeResult"
    }
    
    struct DailyBoxOffice: Decodable {
        let boxofficeType: String
        let showRange: String
        let dailyBoxOfficeList: [MovieInformation]
    }
}
