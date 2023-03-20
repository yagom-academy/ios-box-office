//
//  BoxOfficeItem.swift
//  BoxOffice
//
//  Created by Seoyeon Hong on 2023/03/20.
//

import Foundation

struct BoxOfficItem: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

struct DailyBoxOfficeList: Decodable {
    let rnum: String
    let rank: String
    let rankInten: String
    let rankOldAndNew: RankOldAndNew
    let movieCode: String
    let movieName: String
    let openDate: String
    let salesAmount: String
    let salesShare: String
    let salesInten: String
    let salesChange: String
    let salesAcc: String
    let audienceCount: String
    let audienceInten: String
    let audienceChange: String
    let audienceAcc: String
    let screenCount: String
    let showCount: String

    enum CodingKeys: String, CodingKey {
        case rnum, rank, rankInten, rankOldAndNew
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case audienceCount = "audiCnt"
        case audienceInten = "audiInten"
        case audienceChange = "audiChange"
        case audienceAcc = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
        case salesShare, salesInten, salesChange, salesAcc
    }
}

enum RankOldAndNew: String, Decodable {
    case new = "NEW"
    case old = "OLD"
}
