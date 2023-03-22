//
//  DailyBoxOffice.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/20.
//

struct DailyBoxOffice: Decodable {
    let sequence: String
    let rank: String
    let rankIntensity: String
    let rankOldAndNew: String
    let movieCode: String
    let movieName: String
    let openDate: String
    let salesAmount: String
    let salesShare: String
    let salesIntensity: String
    let salesChange: String
    let salesAccumulation: String
    let audienceCount: String
    let audienceIntensity: String
    let audienceChange: String
    let audienceAccumulation: String
    let screenCount: String
    let showCount: String
    
    private enum CodingKeys: String, CodingKey {
        case sequence = "rnum"
        case rank
        case rankIntensity = "rankInten"
        case rankOldAndNew
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesShare
        case salesIntensity = "salesInten"
        case salesChange
        case salesAccumulation = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceIntensity = "audiInten"
        case audienceChange = "audiChange"
        case audienceAccumulation = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}
