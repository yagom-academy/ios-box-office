//
//  BoxOffice.swift
//  DailyBoxOfficeData
//
//  Created by goat, songjun on 2023/03/20.
//

import Foundation

struct DailyBoxOffice: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let boxOfficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyMovieInformation]

    private enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case showRange
        case dailyBoxOfficeList
    }
}

struct DailyMovieInformation: Decodable {
    let movieNumber: String
    let rank: String
    let rankGap: String
    let rankOldAndNew: String
    let movieCode: String
    let movieName: String
    let openDate: String
    let salesAmount: String
    let salesPercent: String
    let salesGap: String
    let salesGapPercent: String
    let salesAccumulation: String
    let audienceCount: String
    let audienceGap: String
    let audienceGapPercent: String
    let audienceAccumulation: String
    let screenCount: String
    let showCount: String

    private enum CodingKeys: String, CodingKey {
        case movieNumber = "rnum"
        case rank
        case rankGap = "rankInten"
        case rankOldAndNew
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesPercent = "salesShare"
        case salesGap = "salesInten"
        case salesGapPercent = "salesChange"
        case salesAccumulation = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceGap = "audiInten"
        case audienceGapPercent = "audiChange"
        case audienceAccumulation = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}
