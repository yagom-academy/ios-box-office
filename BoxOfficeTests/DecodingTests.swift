//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by Hisop on 2023/11/27.
//

import XCTest
@testable import BoxOffice

final class DecodingTests: XCTestCase {
    let decoder = JSONDecoder()

    func test_init으로_만든_BoxOfficeResult와_JSON을_디코딩한_결과가_같은지_확인() throws {
        let boxofficeType = "일별 박스오피스"
        let showRange = "20220105~20220105"
        
        let rankNumber = "1"
        let rank = "1"
        let rankIntensity = "0"
        let rankOldAndNew = "NEW"
        let movieCode = "20199882"
        let movieName = "경관의 피"
        let openDate = "2022-01-05"
        let salesAmount = "584559330"
        let salesShare = "34.2"
        let salesIntensity = "584559330"
        let salesChange = "100"
        let salesAccumulated = "69228"
        let audienceCount = "64050"
        let audienceIntensity = "64050"
        let audienceChange = "100"
        let audienceAccumulated = "69228"
        let screenCount = "1171"
        let showCount = "4416"
        
        let json: Data = """
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
        
        let dailyBoxOfficeList = DailyBoxOffice(
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
        
        let boxOfficeResult = BoxOfficeResult(
            boxofficeType: boxofficeType,
            showRange: showRange,
            dailyBoxOfficeList: [dailyBoxOfficeList])
        
        let boxOffice = BoxOffice(boxOfficeResult: boxOfficeResult)
        
        XCTAssertEqual(boxOffice, try! decoder.decode(BoxOffice.self, from: json))
    }
}

extension BoxOffice: Equatable {
    public static func == (lhs: BoxOffice, rhs: BoxOffice) -> Bool {
        return lhs.boxOfficeResult == rhs.boxOfficeResult
    }
}

extension BoxOfficeResult: Equatable {
    public static func == (lhs: BoxOfficeResult, rhs: BoxOfficeResult) -> Bool {
        for (index, dailyBoxOffice) in lhs.dailyBoxOfficeList.enumerated() {
            guard dailyBoxOffice == rhs.dailyBoxOfficeList[index] else {
                return false
            }
        }
        guard lhs.boxofficeType == rhs.boxofficeType && 
                lhs.showRange == rhs.showRange else {
            return false
        }
        return true
    }
}

extension DailyBoxOffice: Equatable {
    public static func == (lhs: DailyBoxOffice, rhs: DailyBoxOffice) -> Bool {
        return lhs.rankNumber == rhs.rankNumber &&
        lhs.rank == rhs.rank &&
        lhs.rankIntensity == rhs.rankIntensity &&
        lhs.rankOldAndNew == rhs.rankOldAndNew &&
        lhs.movieCode == rhs.movieCode &&
        lhs.movieName == rhs.movieName &&
        lhs.openDate == rhs.openDate &&
        lhs.salesAmount == rhs.salesAmount &&
        lhs.salesShare == rhs.salesShare &&
        lhs.salesIntensity == rhs.salesIntensity &&
        lhs.salesChange == rhs.salesChange &&
        lhs.salesAccumulated == rhs.salesAccumulated &&
        lhs.audienceCount == rhs.audienceCount &&
        lhs.audienceIntensity == rhs.audienceIntensity &&
        lhs.audienceChange == rhs.audienceChange &&
        lhs.audienceAccumulated == rhs.audienceAccumulated &&
        lhs.screenCount == rhs.screenCount &&
        lhs.showCount == rhs.showCount
    }
}


