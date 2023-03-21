//
//  BoxOffice.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/20.
//

import Foundation

struct BoxOffice: Codable {
    let result: Result
    
    private enum CodingKeys: String, CodingKey {
        case result = "boxOfficeResult"
    }
    
    struct Result: Codable {
        let type: String
        let showRange: String
        let dailyBoxOfficeList: [DailyBoxOfficeItem]
        
        private enum CodingKeys: String, CodingKey {
            case type = "boxofficeType"
            case showRange, dailyBoxOfficeList
        }
    }
}
