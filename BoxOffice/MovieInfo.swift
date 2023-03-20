//
//  MovieInfo.swift
//  BoxOffice
//
//  Created by 레옹아범 ,Andrew on 2023/03/20.
//

import Foundation

struct DailyBoxOffice: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let boxofficeType: String
    let dateRange: String
    let movies: [MovieInfo]
    
    enum CodingKeys: String, CodingKey {
        case boxofficeType = "boxofficeType"
        case dateRange = "showRange"
        case movies = "dailyBoxOfficeList"
    }
}

struct MovieInfo: Decodable {
    let rnum, rank, changedRank, rankStatus: String
    let code, name: String
    let openDate: String
    let salesAmount, salesShare, changedSales, changedSalesRate, totalOfSales: String
    let numberOfAudience, changedAudience, changedAudienceRate, totalOfAudience: String
    let numberOfScreen: String
    let numberOfShowing: String
    
    enum CodingKeys: String, CodingKey {
        case rnum, rank
        case changedRank = "rankInten"
        case rankStatus = "rankOldAndNew"
        case code = "movieCd"
        case name = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesShare
        case changedSales = "salesInten"
        case changedSalesRate = "salesChange"
        case totalOfSales = "salesAcc"
        case numberOfAudience = "audiCnt"
        case changedAudience = "audiInten"
        case changedAudienceRate = "audiChange"
        case totalOfAudience = "audiAcc"
        case numberOfScreen = "scrnCnt"
        case numberOfShowing = "showCnt"
    }
}
