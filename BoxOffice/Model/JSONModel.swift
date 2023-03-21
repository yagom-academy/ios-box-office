//
//  JSONModel.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/20.
//

struct DailyBoxOffice: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let boxOfficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeMovie]
    
    private enum CodingKeys: String, CodingKey {
        case showRange, dailyBoxOfficeList
        case boxOfficeType = "boxofficeType"
    }
}

struct DailyBoxOfficeMovie: Decodable {
    let rankNumber: String
    let rank: String
    let rankDifference: String
    let rankOldAndNew: String
    let movieCode: String
    let movieName: String
    let openDate: String
    let salesAmount: String
    let salesShare: String
    let salesDifference: String
    let salesChangeRatio: String
    let salesAccumulate: String
    let audienceCountOfDate: String
    let audienceDifferenceFromYesterday: String
    let audienceChangeRatio: String
    let accumulatedAudienceCount: String
    let screenCount: String
    let showCount: String
    
    private enum CodingKeys: String, CodingKey {
        case rank, rankOldAndNew, salesShare
        case rankNumber = "rnum"
        case rankDifference = "rankInten"
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesDifference = "salesInten"
        case salesChangeRatio = "salesChange"
        case salesAccumulate = "salesAcc"
        case audienceCountOfDate = "audiCnt"
        case audienceDifferenceFromYesterday = "audiInten"
        case audienceChangeRatio = "audiChange"
        case accumulatedAudienceCount = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}
