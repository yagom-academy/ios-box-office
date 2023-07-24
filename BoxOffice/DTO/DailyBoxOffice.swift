//
//  DailyBoxOffice.swift
//  BoxOffice
//
//  Created by Hyun A Song on 2023/07/24.
//

struct DailyBoxOffice: Decodable {
    let boxofficeType: String
    let showRange: String
    let rnum: String
    let rank: String
    let rankInten: String
    let rankOldAndNew: String
    let movieCd: String
    let movieNm: String
    let openDt: String
    let salesAmt: String
    let salesShare: String
    let salesInten: String
    let salesChange: String
    let salesAcc: String
    let audiCnt: String
    let audiInten: String
    let audiChange: String
    let audiAcc: String
    let scrnCnt: String
    let showCnt: String
    
    enum CodingKeys: String, CodingKey {
        case boxofficeType = "boxOfficeType"
        case showRange
        case rnum = "rawNumber"
        case rank
        case rankInten = "rankIntensification"
        case rankOldAndNew
        case movieCd = "movieCode"
        case movieNm = "movieNumber"
        case openDt = "openDate"
        case salesAmt = "saleAmount"
        case salesShare
        case salesInten = "salesIntensification"
        case salesChange
        case salesAcc = "salesAccumulation"
        case audiCnt = "audienceCount"
        case audiInten = "audienceIntensification"
        case audiChange = "audienceIntensificationChange"
        case audiAcc = "audienceAccumulation"
        case scrnCnt = "screenCount"
        case showCnt = "showPlayCount"
    }
}
