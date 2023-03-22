//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by Jinah Park on 2023/03/20.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    var sut: DecodeManager!
    
    override func setUpWithError() throws {
        sut = DecodeManager()
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
    
    func test_dailyBoxOfficeList의_rank가1위인영화는_경관의피이다() {
        //given
        let dailyBoxOfficeList = sut.decodeBoxOffice()?.boxOfficeResult.dailyBoxOfficeList
        
        //when
        let expectedResult = "경관의 피"
        let resultBoxOfficeList = dailyBoxOfficeList?.filter{ boxOffice in
            boxOffice.rank == "1"
        }
        
        let result = resultBoxOfficeList?.first
        
        //then
        XCTAssertEqual(result?.movieName, expectedResult)
    }
    
    func test_dailyBoxOfficeList의_rank가높은영화는_rank가낮은영화보다_SalesAccumulation이높다() {
        //given
        guard let dailyBoxOfficeList = sut.decodeBoxOffice()?.boxOfficeResult.dailyBoxOfficeList else { return }
 
        //when
        var result: Bool?
        
        for index in 0..<dailyBoxOfficeList.count {
            guard let previous =  Int(dailyBoxOfficeList[index].salesAccumulation),
                  let next = Int(dailyBoxOfficeList[index+1].salesAccumulation) else { return }
            
            guard previous > next else {
                result = false
                return
            }
            result = true
        }
        
        let expectedResult = true
        
        //then
        XCTAssertEqual(result, expectedResult)
    }
}
