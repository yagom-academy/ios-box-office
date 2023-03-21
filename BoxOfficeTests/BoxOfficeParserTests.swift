//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by goat, songjun on 2023/03/20.
//

import XCTest

@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    
    var sut: BoxOfficeParser<BoxOffice>!
    
    override func setUpWithError() throws {
        sut = BoxOfficeParser<BoxOffice>()
    }
    override func tearDownWithError() throws {
       sut = nil
    }

    func test_boxOfficePareser매서드로_boxOfficeType을_불러오면_일별_박스오피스가_결과로_반환된다() {
        //given
        let expectedResult = "일별 박스오피스"
        
        //when
        let result = sut.boxOfficeParse(jsonFileName: "box_office_sample")?.boxOfficeResult.boxOfficeType
        
        //then
        XCTAssertEqual(expectedResult, result)
    }
    
    func test_boxOfficeParser매서드로_DailyBoxOfficeList의_2번째배열의_movieName을_불러오면_스파이더맨노웨이홈이_결과로_반환된다() {
        //given
        let expectedResult = "스파이더맨: 노 웨이 홈"
        
        //when
        let result = sut.boxOfficeParse(jsonFileName: "box_office_sample")?.boxOfficeResult.dailyBoxOfficeList[1].movieName
        
        //then
        XCTAssertEqual(expectedResult, result)
    }

}
