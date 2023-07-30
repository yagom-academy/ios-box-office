//
//  MovieInfo.swift
//  BoxOffice
//
//  Created by karen on 2023/07/26.
//

struct MovieInfo: Decodable {
    let rowNumber: String
    let rank, changedRank, rankingStatus: String
    let code, name, releaseDate: String
    let salesAmount, salesShare, changedSales, changedSalesRate, salesTotal: String
    let audienceCount, changedAudience, changedAudienceRate, audienceTotal: String
    let screenCount, screeningCount: String

    private enum CodingKeys: String, CodingKey {
        case rowNumber = "rnum"
        case rank
        case changedRank = "rankInten"
        case rankingStatus = "rankOldAndNew"
        case code = "movieCd"
        case name = "movieNm"
        case releaseDate = "openDt"
        case salesAmount = "salesAmt"
        case salesShare
        case changedSales = "salesInten"
        case changedSalesRate = "salesChange"
        case salesTotal = "salesAcc"
        case audienceCount = "audiCnt"
        case changedAudience = "audiInten"
        case changedAudienceRate = "audiChange"
        case audienceTotal = "audiAcc"
        case screenCount = "scrnCnt"
        case screeningCount = "showCnt"
    }
}

