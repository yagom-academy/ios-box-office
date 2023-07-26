//
//  MovieInformation.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/07/24.
//

struct MovieInformation: Decodable {
    let rowNumber: String
    let rank: String
    let rankChangeValue: String
    let rankOldAndNew: String
    let movieCode: String
    let movieName: String
    let openDate: String
    let salesAmount: String
    let salesShare: String
    let salesChangeValue: String
    let salesChangeRatio: String
    let salesAccumulate: String
    let audienceCount: String
    let audienceChangeValue: String
    let audienceChangeRatio: String
    let audienceAccumulate: String
    let screenCount: String
    let showCount: String
    
    enum CodingKeys: String, CodingKey {
        case rowNumber = "rnum"
        case rank
        case rankChangeValue = "rankInten"
        case rankOldAndNew
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesShare
        case salesChangeValue = "salesInten"
        case salesChangeRatio = "salesChange"
        case salesAccumulate = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceChangeValue = "audiInten"
        case audienceChangeRatio = "audiChange"
        case audienceAccumulate = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}
