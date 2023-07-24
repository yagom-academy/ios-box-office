//
//  BoxOfficeItem.swift
//  BoxOffice
//
//  Created by EtialMoon, Minsup on 2023/07/24.
//

struct BoxOfficeItem: Decodable {
    let rankNumber: String
    let rank: String
    let amountOfRankChange: String
    let rankOldAndNew: String
    let movieCode: String
    let movieName: String
    let openDate: String
    let salesAmount: String
    let salesShare: String
    let amountOfSalesChange: String
    let rateOfSalesChange: String
    let accumulatedSales: String
    let audienceCount: String
    let amountOfAudienceCountChange: String
    let rateOfAudienceCountChange: String
    let accumulatedAudienceCount: String
    let screenCount: String
    let showCount: String
    
    enum CodingKeys: String, CodingKey {
        case rankNumber = "rnum"
        case rank
        case amountOfRankChange = "rankInten"
        case rankOldAndNew
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesShare
        case amountOfSalesChange = "salesInten"
        case rateOfSalesChange = "salesChange"
        case accumulatedSales = "salesAcc"
        case audienceCount = "audiCnt"
        case amountOfAudienceCountChange = "audiInten"
        case rateOfAudienceCountChange = "audiChange"
        case accumulatedAudienceCount = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}
