//
//  BoxOffice.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/20.
//

import Foundation

struct BoxOffice: Codable {
    let boxOfficeResult: Result
    
    struct Result: Codable {
        let boxOfficeType: String
        let showRange: String
        let dailyBoxOfficeList: [DailyBoxOfficeItem]
        
        private enum CodingKeys: String, CodingKey {
            case boxOfficeType = "boxofficeType"
            case showRange, dailyBoxOfficeList
        }
    }
}
