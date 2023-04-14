//
//  DailyBoxOfficeItem.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/20.
//

import Foundation

struct DailyBoxOfficeItem: Codable, Hashable {
    let rank: String
    let rankingIntensity: String
    let rankOldAndNew: RankOldAndNew
    let movieCode: String
    let movieName: String
    let audienceCount: String
    let audienceAccumulation: String
    
    let identifier = UUID()
    
    private enum CodingKeys: String, CodingKey {
        case rank
        case rankingIntensity = "rankInten"
        case rankOldAndNew
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case audienceCount = "audiCnt"
        case audienceAccumulation = "audiAcc"
    }
}

enum RankOldAndNew: String, Codable {
    case new = "NEW"
    case old = "OLD"
}
