//
//  BoxOffice.swift
//  BoxOffice
//
//  Created by kyungmin, Erick on 2023/07/24.
//

import Foundation

struct BoxOffice: Codable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Codable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

struct DailyBoxOfficeList: Codable {
    let number: String
    let rank, rankIntensity: String
    let rankOldAndNew: String
    let movieCode, movieName: String
    let openDate: String
    let salesAmount, salesShare, salseIntensity, salesChange, salesAccumulation: String
    let audienceCount, audienceIntensity, audienceChange, audienceAccumulation: String
    let screenCount: String
    let showCount: String
    
    enum CodingKeys: String, CodingKey {
        case number = "rnum"
        case rank
        case rankIntensity = "rankInten"
        case rankOldAndNew
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesShare
        case salseIntensity = "salesInten"
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
