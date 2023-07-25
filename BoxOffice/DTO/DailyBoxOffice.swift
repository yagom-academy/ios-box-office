//
//  DailyBoxOffice.swift
//  BoxOffice
//
//  Created by Hyun A Song on 2023/07/24.
//

struct DailyBoxOffice: Decodable {
    let rawNumber: String
    let rank: String
    let rankIntensification: String
    let rankOldAndNew: String
    let movieCode: String
    let movieNumber: String
    let openDate: String
    let saleAmount: String
    let salesShare: String
    let salesIntensification: String
    let salesChange: String
    let salesAccumulation: String
    let audienceCount: String
    let audienceIntensification: String
    let audienceIntensificationChange: String
    let audienceAccumulation: String
    let screenCount: String
    let showPlayCount: String
    
    private enum CodingKeys: String, CodingKey {
        case rawNumber = "rnum"
        case rank
        case rankIntensification = "rankInten"
        case rankOldAndNew
        case movieCode = "movieCd"
        case movieNumber = "movieNm"
        case openDate = "openDt"
        case saleAmount = "salesAmt"
        case salesShare
        case salesIntensification = "salesInten"
        case salesChange
        case salesAccumulation = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceIntensification = "audiInten"
        case audienceIntensificationChange = "audiChange"
        case audienceAccumulation = "audiAcc"
        case screenCount = "scrnCnt"
        case showPlayCount = "showCnt"
    }
}
