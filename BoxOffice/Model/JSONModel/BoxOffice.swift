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
    let targetDateText: String
    let dailyBoxOfficeList: [DailyBoxOffice]
    
    enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case targetDateText = "showRange"
        case dailyBoxOfficeList
    }
}

struct DailyBoxOffice: Decodable {
    let numberText: String
    let rankText: String
    let rankIncrementText: String
    let rankOldAndNew: RankOldAndNew
    let movieCodeText: String
    let movieKoreanName: String
    let openDateText: String
    let salesAmountText: String
    let salesShareText: String
    let salesIncrementText: String
    let salesChangeText: String
    let salesAccumulationText: String
    let audienceCountText: String
    let audienceIncrementText: String
    let audienceChangeText: String
    let audienceAccumulationText: String
    let screenCountText: String
    let showCountText: String
    
    enum CodingKeys: String, CodingKey {
        case rankText = "rank"
        case rankOldAndNew
        case salesShareText = "salesShare"
        case salesChangeText = "salesChange"
        case numberText = "rnum"
        case rankIncrementText = "rankInten"
        case movieCodeText = "movieCd"
        case movieKoreanName = "movieNm"
        case openDateText = "openDt"
        case salesAmountText = "salesAmt"
        case salesIncrementText = "salesInten"
        case salesAccumulationText = "salesAcc"
        case audienceCountText = "audiCnt"
        case audienceIncrementText = "audiInten"
        case audienceChangeText = "audiChange"
        case audienceAccumulationText = "audiAcc"
        case screenCountText = "scrnCnt"
        case showCountText = "showCnt"
    }
}

enum RankOldAndNew: String, Decodable {
    case new = "NEW"
    case old = "OLD"
}
