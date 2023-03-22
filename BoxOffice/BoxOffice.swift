//
//  BoxOffice.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/20.
//

struct BoxOffice: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let boxOfficeType: String
    let targetDate: String
    let dailyBoxOfficeList: [DailyBoxOffice]
    
    enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case targetDate = "showRange"
        case dailyBoxOfficeList
    }
}

struct DailyBoxOffice: Decodable {
    let number: String
    let rank: String
    let rankIncrement: String
    let rankOldAndNew: RankOldAndNew
    let movieCode: String
    let movieKoreanName: String
    let openDate: String
    let salesAmount: String
    let salesShare: String
    let salesIncrement: String
    let salesChange: String
    let salesAccumulation: String
    let audienceCount: String
    let audienceIncrement: String
    let audienceChange: String
    let audienceAccumulation: String
    let screenCount: String
    let showCount: String
    
    enum CodingKeys: String, CodingKey {
        case rank
        case rankOldAndNew
        case salesShare
        case salesChange
        case number = "rnum"
        case rankIncrement = "rankInten"
        case movieCode = "movieCd"
        case movieKoreanName = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesIncrement = "salesInten"
        case salesAccumulation = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceIncrement = "audiInten"
        case audienceChange = "audiChange"
        case audienceAccumulation = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}

enum RankOldAndNew: String, Decodable {
    case new = "NEW"
    case old = "OLD"
}
