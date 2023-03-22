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

extension BoxOffice: Equatable {
    public static func == (lhs: BoxOffice, rhs: BoxOffice) -> Bool {
        return lhs.boxOfficeResult == rhs.boxOfficeResult
    }
}

extension BoxOfficeResult: Equatable {
    public static func == (lhs: BoxOfficeResult, rhs: BoxOfficeResult) -> Bool {
        return lhs.boxOfficeType == rhs.boxOfficeType && lhs.targetDate == rhs.targetDate && lhs.dailyBoxOfficeList == rhs.dailyBoxOfficeList
    }
}

extension DailyBoxOffice: Equatable {
    public static func == (lhs: DailyBoxOffice, rhs: DailyBoxOffice) -> Bool {
        return lhs.number == rhs.number
        && lhs.rank == rhs.rank
        && lhs.rankIncrement == rhs.rankIncrement
        && lhs.rankOldAndNew == rhs.rankOldAndNew
        && lhs.movieCode == rhs.movieCode
        && lhs.movieKoreanName == rhs.movieKoreanName
        && lhs.openDate == rhs.openDate
        && lhs.salesAmount == rhs.salesAmount
        && lhs.salesShare == rhs.salesShare
        && lhs.salesIncrement == rhs.salesIncrement
        && lhs.salesChange == rhs.salesChange
        && lhs.salesAccumulation == rhs.salesAccumulation
        && lhs.audienceCount == rhs.audienceCount
        && lhs.audienceIncrement == rhs.audienceIncrement
        && lhs.audienceChange == rhs.audienceChange
        && lhs.audienceAccumulation == rhs.audienceAccumulation
        && lhs.screenCount == rhs.screenCount
        && lhs.showCount == rhs.showCount
    }
}
