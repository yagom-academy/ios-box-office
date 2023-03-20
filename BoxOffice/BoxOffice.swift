//
//  BoxOffice.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/03/20.
//

struct BoxOffice: Codable {
    let boxofficeType, showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

struct DailyBoxOfficeList: Codable {
    let number, rank, rankIncrement: String
    let rankOldAndNew: RankOldAndNew
    let movieCode, movieKoreanName, openDate, salesAmount: String
    let salesShare, salesIncrement, salesChange, salesAccumulation: String
    let audienceCount, audienceIncrement, audienceChange, audienceAccumulation: String
    let screenCount, showCount: String
    
    enum CodingKeys: String, CodingKey {
        case rank, rankOldAndNew, salesShare, salesChange
        case number = "rnum"
        case rankIncrement = "rankInten"
        case movieCode = "movieCd"
        case movieKoreanName = "movieNm"
        case openDate = "opendDt"
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

enum RankOldAndNew: String, Codable {
    case new = "NEW"
    case old = "OLD"
}

extension BoxOffice: Equatable {
    public static func == (lhs: BoxOffice, rhs: BoxOffice) -> Bool {
        return lhs.boxofficeType == rhs.boxofficeType && lhs.showRange == rhs.showRange && lhs.dailyBoxOfficeList == rhs.dailyBoxOfficeList
    }
}

extension DailyBoxOfficeList: Equatable {
    public static func == (lhs: DailyBoxOfficeList, rhs: DailyBoxOfficeList) -> Bool {
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


