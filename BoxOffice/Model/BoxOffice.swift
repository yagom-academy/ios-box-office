//
//  BoxOffice.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/07/25.
//

struct BoxOffice: Decodable {
    let boxOfficeResult: DailyBoxOfficeResult
}

struct DailyBoxOfficeResult: Decodable {
    let boxOfficeType: String
    let showRange: String
    let dailyBoxOfficeList: [BoxOfficeData]
    
    private enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case showRange
        case dailyBoxOfficeList
    }
}

struct BoxOfficeData: Decodable {
    let number: String
    let rank: String
    let rankIntensity: String
    let rankOldOrNew: String
    let movieCode: String
    let movieName: String
    let openingDate: String
    let salesAmount: String
    let salesShare: String
    let salesIntensity: String
    let salesChangeRatio: String
    let salesAccumulate: String
    let audienceCount: String
    let audienceIntensity: String
    let audienceChangeRatio: String
    let audienceAccumulate: String
    let screenCount: String
    let showCount: String
    
    private enum CodingKeys: String, CodingKey {
        case number = "rnum"
        case rank
        case rankIntensity = "rankInten"
        case rankOldOrNew = "rankOldAndNew"
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openingDate = "openDt"
        case salesAmount = "salesAmt"
        case salesShare
        case salesIntensity = "salesInten"
        case salesChangeRatio = "salesChange"
        case salesAccumulate = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceIntensity = "audiInten"
        case audienceChangeRatio = "audiChange"
        case audienceAccumulate = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}
