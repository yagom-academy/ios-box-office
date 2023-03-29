//
//  InfoObject.swift
//  BoxOffice
//
//  Created by 레옹아범 ,Andrew on 2023/03/20.
//

struct InfoObject: Decodable, Hashable {
    let rnum, rank, changedRank, rankStatus: String
    let code, name: String
    let openDate: String
    let salesAmount, salesShare, changedSales, changedSalesRate, totalOfSales: String
    let numberOfAudience, changedAudience, changedAudienceRate, totalOfAudience: String
    let numberOfScreen: String
    let numberOfShowing: String
    
    var audienceInfoText: String {
        let formatNumberOfAudience = numberOfAudience.formatDecimal()
        let formatTotalOfAudience = totalOfAudience.formatDecimal()
        
        guard let todayOfAudienceText = formatNumberOfAudience,
              let totalOfAudienceText = formatTotalOfAudience else { return "" }
        return "오늘 \(todayOfAudienceText) / 총 \(totalOfAudienceText)"
    }
    
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
