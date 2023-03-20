//
//  JSONModel.swift
//  BoxOffice
//
//  Created by Muri, Rowan on 2023/03/20.
//

struct BoxOfficeResult: Decodable {
    let boxOfficeResult: Service
}

struct Service: Decodable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [MovieInformation]
}

struct MovieInformation: Decodable {
    let rankNumber: String
    let rank: String
    let rankDifference : String
    let rankOldAndNew: String
    let movieCode: String
    let movieName: String
    let openDate: String
    let salesAmount: String
    let salesShare: String
    let salesDifference: String
    let salesChangeRatio: String
    let salesAccumulate: String
    let audienceCount: String
    let audienceDifference: String
    let audienceChangeRatio: String
    let audienceAccumulate: String
    let screenCount: String
    let showCount: String
    
    private enum CodingKeys: String, CodingKey {
        case rankNumber = "rnum"
        case rank
        case rankDifference = "rankInten"
        case rankOldAndNew
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesShare
        case salesDifference = "salesInten"
        case salesChangeRatio = "salesChange"
        case salesAccumulate = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceDifference = "audiInten"
        case audienceChangeRatio = "audiChange"
        case audienceAccumulate = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}
