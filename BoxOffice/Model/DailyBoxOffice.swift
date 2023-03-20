//
//  DailyBoxOffice.swift
//  BoxOffice
//
//  Created by Rhode, Rilla on 2023/03/20.
//

import Foundation

struct DailyBoxOffice {
    let number: String
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
        case rnum = "number"
        case rank
        case rankInten = "rankIntensity"
        case rankOldAndNew
        case movieCd = "movieCode"
        case movieNm = "movieName"
        case openDt = "openDate"
        case salesAmt = "salesAmount"
        case salesShare
        case salesInten = "salesIntensity"
        case salesChange
        case salesAcc = "salesAccumulation"
        case audiCnt = "audienceCount"
        case audiInten = "audienceIntensity"
        case audiChange
        case audiAcc = "audienceAccumulation"
        case scrnCnt = "screenCount"
        case showCnt = "showCount"
    }
}
