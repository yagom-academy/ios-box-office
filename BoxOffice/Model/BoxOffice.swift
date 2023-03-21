//
//  BoxOffice.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/03/20.
//

import Foundation

struct BoxOffice: Decodable {
    let boxOfficeResult: BoxOfficeResult
}
   
struct BoxOfficeResult: Decodable {
    let boxOfficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOffice]
    
    private enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case showRange
        case dailyBoxOfficeList
    }
}

struct DailyBoxOffice: Decodable {
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
        case salesPercent = "salesShare" // 해당일자 판매 비율
        case salesGap = "salesInten" // 전일 대비 매출액 증감분
        case salesGapPercent = "salesChange" // 전일 대비 매출애 증감 비율
        case salesAccumulation = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceGap = "audiInten"
        case audienceGapPercent = "audiChange"
        case audienceAccumulation = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}




