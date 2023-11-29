//
//  MovieTests.swift
//  MovieTests
//
//  Created by jyubong, kiseok
//

import XCTest
@testable import BoxOffice

final class MovieTests: XCTestCase {

    func test_init을통해만든Movie타입과Json데이터를_비교했을때_서로같다() {
        //given
        let boxOfficeType = "일별 박스오피스"
        let showRange = "20220105~20220105"
        let number = "1"
        let rank = "1"
        let rankFluctuation = "0"
        let rankOldAndNew = "NEW"
        let movieCode = "20199882"
        let movieName = "경관의 피"
        let openDate = "2022-01-05"
        let salesAmount = "584559330"
        let salesShare = "34.2"
        let salesFluctuation = "584559330"
        let salesChange = "100"
        let salesAccumulation = "631402330"
        let audienceCount = "64050"
        let audienceFluctuation = "64050"
        let audienceChange = "100"
        let audienceAccumulation = "69228"
        let screenCount = "1171"
        let showCount = "4416"
        
        let dailyBoxOfficeList = DailyBoxOfficeList(
            number: number,
            rank: rank,
            rankFluctuation: rankFluctuation,
            rankOldAndNew: rankOldAndNew,
            movieCode: movieCode,
            movieName: movieName,
            openDate: openDate,
            salesAmount: salesAmount,
            salesShare: salesShare,
            salesFluctuation: salesFluctuation,
            salesChange: salesChange,
            salesAccumulation: salesAccumulation,
            audienceCount: audienceCount,
            audienceFluctuation: audienceFluctuation,
            audienceChange: audienceChange,
            audienceAccumulation: audienceAccumulation,
            screenCount: screenCount,
            showCount: showCount
        )
        
        let boxOfficeResult = BoxOfficeResult(
            boxOfficeType: boxOfficeType,
            showRange: showRange,
            dailyBoxOfficeList: [dailyBoxOfficeList]
        )
        
        let movie = Movie(boxOfficeResult: boxOfficeResult)
        let data = TestMovieJsonData.json.data(using: .utf8)!
        let jsonData = try! JSONDecoder().decode(Movie.self, from: data)
        
        //when, then
        XCTAssertEqual(movie, jsonData)
    }
}

extension DailyBoxOfficeList: Equatable {
    public static func == (lhs: DailyBoxOfficeList, rhs: DailyBoxOfficeList) -> Bool {
        return lhs.number == rhs.number &&
        lhs.rank == rhs.rank &&
        lhs.rankFluctuation == rhs.rankFluctuation &&
        lhs.rankOldAndNew == rhs.rankOldAndNew &&
        lhs.movieCode == rhs.movieCode &&
        lhs.openDate == rhs.openDate &&
        lhs.salesAmount == rhs.salesAmount &&
        lhs.salesShare == rhs.salesShare &&
        lhs.salesFluctuation == rhs.salesFluctuation &&
        lhs.salesChange == rhs.salesChange &&
        lhs.salesAccumulation == rhs.salesAccumulation &&
        lhs.audienceCount == rhs.audienceCount &&
        lhs.audienceFluctuation == rhs.audienceFluctuation &&
        lhs.audienceChange == rhs.audienceChange &&
        lhs.audienceAccumulation == rhs.audienceAccumulation &&
        lhs.screenCount == rhs.screenCount &&
        lhs.showCount == rhs.showCount
    }
}

extension BoxOfficeResult: Equatable {
    public static func == (lhs: BoxOfficeResult, rhs: BoxOfficeResult) -> Bool {
        return lhs.boxOfficeType == rhs.boxOfficeType &&
        lhs.showRange == rhs.showRange &&
        lhs.dailyBoxOfficeList == rhs.dailyBoxOfficeList
    }
}

extension Movie: Equatable {
    public static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.boxOfficeResult == rhs.boxOfficeResult
    }
}
