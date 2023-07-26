//
//  MovingInfo.swift
//  BoxOffice
//
//  Created by redmango, Jusbug on 2023/07/24.
//

import Foundation

struct BoxOffice: Decodable {
    let boxOfficeResult: BoxOfficeInfo
}

struct BoxOfficeInfo: Decodable {
    let boxOfficeType: String
    let showRange: String
    let dailyBoxOfficeList: [MovieInfo]
    
    private enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case showRange
        case dailyBoxOfficeList
    }
}

struct MovieInfo: Decodable {
    let rankNumber: String
    let rank: String
    let rankInten: String
    let rankOldAndNew: String
    let movieCode: String
    let movieName: String
    let openDate: String
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
    
    private enum CodingKeys: String, CodingKey {
        case rank
        case rankInten
        case rankOldAndNew
        case salesAmt
        case salesShare
        case salesInten
        case salesChange
        case salesAcc
        case audiCnt
        case audiInten
        case audiChange
        case audiAcc
        case scrnCnt
        case showCnt
        case rankNumber = "rnum"
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
    }
}
