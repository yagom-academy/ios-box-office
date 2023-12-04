//
//  MockBoxOfficeData.swift
//  BoxOfficeTests
//
//  Created by Hisop on 2023/12/04.
//

import Foundation
@testable import BoxOffice

struct MockBoxOfficeData {
    let boxofficeType: String
    let showRange: String
    
    let rankNumber: String
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
    let salesAccumulated: String
    let audienceCount: String
    let audienceIntensity: String
    let audienceChange: String
    let audienceAccumulated: String
    let screenCount: String
    let showCount: String
    
    let dailyBoxOffice: DailyBoxOffice
    let boxOfficeResult: BoxOfficeResult
    let boxOffice: BoxOffice
    
    init() {
        boxofficeType = "일별 박스오피스"
        showRange = "20220105~20220105"
        
        rankNumber = "1"
        rank = "1"
        rankIntensity = "0"
        rankOldAndNew = "NEW"
        movieCode = "20199882"
        movieName = "경관의 피"
        openDate = "2022-01-05"
        salesAmount = "584559330"
        salesShare = "34.2"
        salesIntensity = "584559330"
        salesChange = "100"
        salesAccumulated = "69228"
        audienceCount = "64050"
        audienceIntensity = "64050"
        audienceChange = "100"
        audienceAccumulated = "69228"
        screenCount = "1171"
        showCount = "4416"
        
        dailyBoxOffice = DailyBoxOffice(
            rankNumber: rankNumber,
            rank: rank,
            rankIntensity: rankIntensity,
            rankOldAndNew: rankOldAndNew,
            movieCode: movieCode,
            movieName: movieName,
            openDate: openDate,
            salesAmount: salesAmount,
            salesShare: salesShare,
            salesIntensity: salesIntensity,
            salesChange: salesChange,
            salesAccumulated: salesAccumulated,
            audienceCount: audienceCount,
            audienceIntensity: audienceIntensity,
            audienceChange: audienceChange,
            audienceAccumulated: audienceAccumulated,
            screenCount: screenCount,
            showCount: showCount)
        
        boxOfficeResult = BoxOfficeResult(
            boxofficeType: boxofficeType,
            showRange: showRange,
            dailyBoxOfficeList: [dailyBoxOffice])
        
        boxOffice = BoxOffice(boxOfficeResult: boxOfficeResult)
    }
    
    func makeData() -> Data {
        return """
                {
                "boxOfficeResult": {
                    "boxofficeType":"\(boxofficeType)",
                    "showRange":"\(showRange)",
                    "dailyBoxOfficeList":
                    [{
                        "rnum":"\(rankNumber)",
                        "rank":"\(rank)",
                        "rankInten":"\(rankIntensity)",
                        "rankOldAndNew":"\(rankOldAndNew)",
                        "movieCd":"\(movieCode)",
                        "movieNm":"\(movieName)",
                        "openDt":"\(openDate)",
                        "salesAmt":"\(salesAmount)",
                        "salesShare":"\(salesShare)",
                        "salesInten":"\(salesIntensity)",
                        "salesChange":"\(salesChange)",
                        "salesAcc":"\(salesAccumulated)",
                        "audiCnt":"\(audienceCount)",
                        "audiInten":"\(audienceIntensity)",
                        "audiChange":"\(audienceChange)",
                        "audiAcc":"\(audienceAccumulated)",
                        "scrnCnt":"\(screenCount)",
                        "showCnt":"\(showCount)",
                    }]
                }
            }
            """.data(using: .utf8)!
    }
}
