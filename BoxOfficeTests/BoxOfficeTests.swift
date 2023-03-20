//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by Christy, Hyemory on 2023/03/20.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    var sut: BoxOffice!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Decoder().decodeBoxOffice()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_디코딩할때_nil을반환하지않는다() {
        // then
        XCTAssertNotNil(sut)
    }
    
    func test_boxOfficeType값이_일별_박스오피스이다() {
        // given
        let expectation = "일별 박스오피스"
        
        // when
        let result = sut.boxOfficeResult.boxOfficeType
        
        // then
        XCTAssertEqual(expectation, result)
    }
    
    func test_dailyBoxOfficeList의_영화의개수는_10개가_맞다() {
        // given
        let movieCount = sut.boxOfficeResult.dailyBoxOfficeList.count
        let expectation = 10
        
        // when
        let result = movieCount == expectation
        
        // then
        XCTAssertTrue(result)
    }
    
    func test_dailyBoxOfficeList의_배열의_마지막_영화제목은_엔칸토이다() {
        // given
        let expectation = "엔칸토: 마법의 세계"
        
        // when
        let result = sut.boxOfficeResult.dailyBoxOfficeList.last?.movieName
        
        // then
        XCTAssertEqual(expectation, result)
    }
}
