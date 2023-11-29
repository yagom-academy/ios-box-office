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
        let movie = DummyMovie().movie
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
