//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by Jinah Park on 2023/03/20.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    var sut: Decoder!
    
    override func setUpWithError() throws {
        sut = Decoder()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_디코딩시_샘플JSON이주어졌을때_BoxOffice는nil이아니다() {
        //given
        
        //when
        let result = sut.decodeBoxOffice()
        //then
        XCTAssertNotNil(result)
    }
    
    func test_디코딩시_샘플JSON이주어졌을때_BoxOfficeResult는nil이아니다() {
        //given
        
        //when
        let result = sut.decodeBoxOffice()?.boxOfficeResult
        //then
        XCTAssertNotNil(result)
    }
    
    func test_디코딩시_샘플JSON이주어졌을때_DailyBoxOfficeList는nil이아니다() {
        //given
        
        //when
        let result = sut.decodeBoxOffice()?.boxOfficeResult.dailyBoxOfficeList
        //then
        XCTAssertNotNil(result)
    }
    
    func test_디코딩시_샘플JSON이주어졌을때_dailyBoxOfficeList는10개의요소를가진다() {
        //given
        
        //when
        let result = sut.decodeBoxOffice()?.boxOfficeResult.dailyBoxOfficeList.count
        let expectedResult = 10
        //then
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_디코딩시_첫번째인덱스의number의value가Int형태를가진다() {
        //given
        guard let number = sut.decodeBoxOffice()?.boxOfficeResult.dailyBoxOfficeList[0].number else { return }
        //when
        let result = Int(number)
        //then
        XCTAssertNotNil(result)
    }
    
    func test_디코딩시_첫번째인덱스의salesShare의value가Double형태를가진다() {
        //given
        guard let number = sut.decodeBoxOffice()?.boxOfficeResult.dailyBoxOfficeList[0].salesShare else { return }
        //when
        let result = Double(number)
        //then
        XCTAssertNotNil(result)
    }
}
