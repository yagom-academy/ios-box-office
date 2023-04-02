//
//  DailyBoxOfficeItem.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/20.
//

import Foundation

struct DailyBoxOfficeItem: Codable, Hashable {
    let rowNumber: String
    let rank: String
    let rankingIntensity: String
    let rankOldAndNew: RankOldAndNew
    let movieCode: String
    let movieName: String
    let openingDate: String
    let salesAmount: String
    let salesShare: String
    let salesIntensity: String
    let salesChange: String
    let salesAccumulation: String
    let audienceCount: String
    let audienceIntensity: String
    let audienceChange: String
    let audienceAccumulation: String
    let screenCount: String
    let showCount: String
    
    let identifier = UUID()
    
    private enum CodingKeys: String, CodingKey {
        case rowNumber = "rnum"
        case rank
        case rankingIntensity = "rankInten"
        case rankOldAndNew
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openingDate = "openDt"
        case salesAmount = "salesAmt"
        case salesShare
        case salesIntensity = "salesInten"
        case salesChange
        case salesAccumulation = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceIntensity = "audiInten"
        case audienceChange = "audiChange"
        case audienceAccumulation = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}

enum RankOldAndNew: String, Codable {
    case new = "NEW"
    case old = "OLD"
}
