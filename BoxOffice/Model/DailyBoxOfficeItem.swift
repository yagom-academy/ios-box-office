//
//  DailyBoxOfficeItem.swift
//  BoxOffice
//
//  Created by Morgan, Toy on 11/27/23.
//

struct DailyBoxOfficeItem: Decodable {
    let rowNumber: String
    let rank: String
    let dailyRankChange: String
    let rankOldAndNew: String
    let movieCode: String
    let movieName: String
    let openDate: String
    let totalSales: String
    let salesProfitLossRatio: String
    let salesIncrease: String
    let salesChange : String
    let salesAccunulation : String
    let audienceCount : String
    let audienceChange : String
    let audienceRatioChange : String
    let audienceAccunulation : String
    let screenCount : String
    let showCount : String
    
    private enum CodingKeys: String, CodingKey {
        case rowNumber = "rnum"
        case rank
        case dailyRankChange = "rankInten"
        case rankOldAndNew
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case totalSales = "salesAmt"
        case salesProfitLossRatio = "salesShare"
        case salesIncrease = "salesInten"
        case salesChange
        case salesAccunulation = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceChange = "audiInten"
        case audienceRatioChange = "audiChange"
        case audienceAccunulation = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}

