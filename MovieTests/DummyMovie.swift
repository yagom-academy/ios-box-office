//
//  DummyMovie.swift
//  MovieTests
//
//  Created by jyubong on 11/29/23.
//

@testable import BoxOffice

struct DummyMovie {
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
