//
//  Movie.swift
//  BoxOffice
//
//  Created by jyubong, kiseok
//

import Foundation

struct Movie: Codable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Codable {
    let boxOfficeType, showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
    
    enum CodingKeys: String, CodingKey {
        case showRange, dailyBoxOfficeList
        case boxOfficeType = "boxofficeType"
    }
}

struct DailyBoxOfficeList: Codable {
    let number, rank, rankFluctuation: String
    let rankOldAndNew: String
    let movieCode, movieName, openDate, salesAmount: String
    let salesShare, salesFluctuation, salesChange, salesAccumulation: String
    let audienceCount, audienceFluctuation, audienceChange, audienceAccumulation: String
    let screenCount, showCount: String

    enum CodingKeys: String, CodingKey {
        case rank, rankOldAndNew, salesShare, salesChange
        case number = "rnum"
        case rankFluctuation = "rankInten"
        case movieCode = "movieCD"
        case movieName = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesFluctuation = "salesInten"
        case salesAccumulation = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceFluctuation = "audiInten"
        case audienceChange = "audiChange"
        case audienceAccumulation = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}
