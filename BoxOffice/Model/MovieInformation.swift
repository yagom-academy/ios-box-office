//
//  MovieInformation.swift
//  BoxOffice
//
//  Created by Zion, Hemg on 2023/07/24.
//

struct MovieInformation: Decodable, Equatable {
    let number: String
    let rank: String
    let rankInten: String
    let rankOldAndNew: String
    let movieCode: String
    let movieName: String
    let openDate: String
    let salesAmount: String
    let salesShare: String
    let salesInten: String
    let salesChange: String
    let salesAccumulate: String
    let audienceCount: String
    let audienceInten: String
    let audienceChange: String
    let audienceAccumulate: String
    let screenCount: String
    let showCount: String
    
    private enum CodingKeys: String, CodingKey {
        case number = "rnum"
        case rank, rankInten, rankOldAndNew
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesShare, salesInten, salesChange
        case salesAccumulate = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceInten = "audiInten"
        case audienceChange = "audiChange"
        case audienceAccumulate = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}
