//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by kaki, harry on 2023/03/20.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    private var sut: BoxOffice!
    
    override func setUpWithError() throws {
        let jsonDecoder = JSONDecoder()
        let dataAsset = NSDataAsset(name: "BoxOffice")!
        
        sut = try! jsonDecoder.decode(BoxOffice.self, from: dataAsset.data)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_boxOfficeResult의_boxOfficeType은_문자열_일별박스오피스이다() {
        // given
        let expectedResult = "일별 박스오피스"
     
        // when
        let boxOfficeType = sut.boxOfficeResult.boxOfficeType
        
        // then
        XCTAssertEqual(expectedResult, boxOfficeType)
    }
    
    func test_첫번째_dailyBoxOffice의_number값이_문자열1이다() {
        // given
        let expectedResult = "1"
     
        // when
        let boxOfficeNumber = sut.boxOfficeResult.dailyBoxOfficeList[0].numberText
        
        // then
        XCTAssertEqual(expectedResult, boxOfficeNumber)
    }
    
    func test_첫번째_dailyBoxOffice의_movieKoreanName값이_문자열_경관의피이다() {
        // given
        let expectedResult = "경관의 피"
     
        // when
        let moviewKoreanName = sut.boxOfficeResult.dailyBoxOfficeList[0].movieKoreanName
        
        // then
        XCTAssertEqual(expectedResult, moviewKoreanName)
    }
    
    func test_두번째_dailyBoxOffice의_number값이_문자열2이다() {
        // given
        let expectedResult = "2"
     
        // when
        let boxOfficeNumber = sut.boxOfficeResult.dailyBoxOfficeList[1].numberText
        
        // then
        XCTAssertEqual(expectedResult, boxOfficeNumber)
    }
    
    func test_두번째_dailyBoxOffice의_rankOldAndNew값이_old이다() {
        // given
        let expectedResult: RankOldAndNew = .old
     
        // when
        let rankOldAndNew = sut.boxOfficeResult.dailyBoxOfficeList[1].rankOldAndNew
        
        // then
        XCTAssertEqual(expectedResult, rankOldAndNew)
    }
}
