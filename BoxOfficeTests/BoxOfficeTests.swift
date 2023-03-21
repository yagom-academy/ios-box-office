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
        sut = try AssetDecoder().decode(name: "box_office_sample", type: BoxOffice.self)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_잘못된JSON파일이름으로_디코딩했을때_decodeFailed에러를던진다() {
        // given
        let invalidJsonFileName = "invalid_name"
        let errorMessage = DecoderError.decodeFailed
        var error: DecoderError?
        
        // when
        XCTAssertThrowsError(try AssetDecoder().decode(name: invalidJsonFileName, type: BoxOffice.self)) {
            errorHandler in
            error = errorHandler as? DecoderError
        }
        
        // then
        XCTAssertEqual(error, errorMessage)
    }
    
    func test_boxOfficeType값이_일별_박스오피스이다() {
        // given
        let expectation = "일별 박스오피스"
        
        // when
        let result = sut.result.type
        
        // then
        XCTAssertEqual(expectation, result)
    }
    
    func test_dailyBoxOfficeList의_영화의개수는_10개가_맞다() {
        // given
        let movieCount = sut.result.dailyBoxOfficeList.count
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
        let result = sut.result.dailyBoxOfficeList.last?.movieName
        
        // then
        XCTAssertEqual(expectation, result)
    }
}
