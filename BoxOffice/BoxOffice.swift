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
    let moviewCode, movieKoreanName, openDate, salesAmount: String
    let salesShare, salesIncrement, salesChange, salesAccumulation: String
    let audienceCount, audienceIncrement, audienceChange, audienceAccumulation: String
    let screenCount, showCount: String
    
    enum CodingKeys: String, CodingKey {
        case rank, rankOldAndNew, salesShare, salesChange
        case number = "rnum"
        case rankIncrement = "rankInten"
        case moviewCode = "movieCd"
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


