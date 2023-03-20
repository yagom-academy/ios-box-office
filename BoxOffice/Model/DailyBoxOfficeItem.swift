//
//  DailyBoxOfficeItem.swift
//  BoxOffice
//
//  Created by Christy, Hyemory on 2023/03/20.
//

import Foundation

struct DailyBoxOfficeItem: Codable {
    let number: String
    let rank, rankingIntensity, rankOldAndNew: String
    let movieCode, movieName, openingDate: String
    let salesAmount, salesShare, salesIntensity, salesChange, salesAccumulation: String
    let audienceCount, audienceIntensity, audienceChange, audienceAccumulation: String
    let screenCount: String
    let showCount: String
    
    private enum CodingKeys: String, CodingKey {
        case number = "rnum"
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
