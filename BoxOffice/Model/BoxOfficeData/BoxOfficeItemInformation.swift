//
//  BoxOfficeItemInformation.swift
//  BoxOffice
//
//  Created by hoon, mint on 2023/07/25.
//

struct BoxOfficeItemInformation: Decodable {
    let number: String
    let rank: String
    let rankVariation: String
    let rankOldAndNew: RankOldAndNew
    let movieCode: String
    let movieName: String
    let openDate: String
    let salesAmount: String
    let salesShare: String
    let salesVariation: String
    let salesChange: String
    let salesAccumulate: String
    let audienceCount: String
    let audienceVariation: String
    let audienceChange: String
    let audienceAccumulate: String
    let screenCount: String
    let showCount: String
    
    enum RankOldAndNew: String, Decodable {
        case old = "OLD"
        case new = "NEW"
    }
    
    enum CodingKeys: String, CodingKey {
        case number = "rnum"
        case rank
        case rankVariation = "rankInten"
        case rankOldAndNew
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesShare
        case salesVariation = "salesInten"
        case salesChange
        case salesAccumulate = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceVariation = "audiInten"
        case audienceChange = "audiChange"
        case audienceAccumulate = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}
