//
//  BoxOffice.swift
//  BoxOffice
//
//  Created by goat, songjun on 2023/03/20.
//

import Foundation

struct BoxOfficeResult: Decodable {
    let boxOfficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
    
    private enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case showRange, dailyBoxOfficeList
    }
    
    struct DailyBoxOfficeList: Decodable {
        let rnum: String
        let rank: String
        let rankInten: String
        let rankOldAndNew: String
        let moviewCd: String
        let moviewNm: String
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
    }
}
