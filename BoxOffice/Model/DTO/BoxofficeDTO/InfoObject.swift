//
//  InfoObject.swift
//  BoxOffice
//
//  Created by 레옹아범 ,Andrew on 2023/03/20.
//

import UIKit

struct InfoObject: Decodable, Hashable {
    let rnum, changedRank: String
    let rankStatus: RankStatus
    let rank: String
    let code, name: String
    private let openDate: String
    private let salesAmount, salesShare, changedSales, changedSalesRate, totalOfSales: String
    let numberOfAudience, changedAudience, changedAudienceRate, totalOfAudience: String
    private let numberOfScreen: String
    private let numberOfShowing: String
    
    enum RankStatus: String, Decodable {
        case old = "OLD"
        case new = "NEW"
    }
    
    private enum CodingKeys: String, CodingKey {
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
