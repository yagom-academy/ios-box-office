//
//  DummyMovie.swift
//  MovieTests
//
//  Created by jyubong, Kiseok on 11/29/23.
//

@testable import BoxOffice

struct DummyMovie {
    private let boxOfficeType = "일별 박스오피스"
    private let showRange = "20220105~20220105"
    private let number = "1"
    private let rank = "1"
    private let rankFluctuation = "0"
    private let rankOldAndNew = "NEW"
    private let movieCode = "20199882"
    private let movieName = "경관의 피"
    private let openDate = "2022-01-05"
    private let salesAmount = "584559330"
    private let salesShare = "34.2"
    private let salesFluctuation = "584559330"
    private let salesChange = "100"
    private let salesAccumulation = "631402330"
    private let audienceCount = "64050"
    private let audienceFluctuation = "64050"
    private let audienceChange = "100"
    private let audienceAccumulation = "69228"
    private let screenCount = "1171"
    private let showCount = "4416"
    
    private var dailyBoxOfficeList: DailyBoxOfficeList {
        DailyBoxOfficeList(
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
    }
    
    private var boxOfficeResult: BoxOfficeResult {
        BoxOfficeResult(boxOfficeType: boxOfficeType,
        showRange: showRange,
        dailyBoxOfficeList: [dailyBoxOfficeList])
    }
    
    var movie: Movie {
        return Movie(boxOfficeResult: boxOfficeResult)
    }
}
