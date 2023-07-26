//
//  DecodingManagerTests.swift
//  DecodingManagerTests
//
//  Created by Dasan & Whales on 2023/07/25.
//

import XCTest
@testable import BoxOffice

final class DecodingManagerTests: XCTestCase {
    private var sut: DecodingManager!
    
    override func setUpWithError() throws {
        sut = DecodingManager()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_일치하는_dataAsset이없을때_notFoundAsset에러를_던진다() {
        //given
        let fileName = "없는파일이름"
        
        //when, then
        XCTAssertThrowsError(try sut.decodeJSON(fileName: fileName) as BoxOffice) { error in
            XCTAssertEqual(error as? DataError, DataError.notFoundAsset)
        }
    }
    
    func test_일치하는_dataAsset가있을때_notFoundAsset에러를_던지지않는다() {
        //given
        let fileName = "box_office_sample"
        
        //when, then
        XCTAssertNoThrow(try sut.decodeJSON(fileName: fileName) as BoxOffice)
    }
    
    func test_Model타입과_JSON데이터의_key가달라_decoding이_실패했을때_failedDecoding에러를_던진다() {
        //given
        let fileName = "box_office_sample_test"
        
        //when, then
        XCTAssertThrowsError(try sut.decodeJSON(fileName: fileName) as BoxOffice) { error in
            XCTAssertEqual(error as? DataError, DataError.failedDecoding)
        }
    }
    
    func test_Model타입과_JSON데이터의_key가같아_decoding이_성공했을때_failedDecoding에러를_던지지않는다() {
        //given
        let fileName = "box_office_sample"
        
        //when, then
        XCTAssertNoThrow(try sut.decodeJSON(fileName: fileName) as BoxOffice)
    }
    
    func test_decoding에_성공한_boxOffice의_boxofficeType은_일별박스오피스이다() {
        //given
        let data: BoxOffice = try! sut.decodeJSON(fileName: "box_office_sample")
        let expectation = "일별 박스오피스"
        
        //when
        let result = data.boxOfficeResult.boxOfficeType
        
        //then
        XCTAssertEqual(expectation, result)
    }
    
    func test_decoding에_성공한_boxOffice의_dailyBoxOfficeList의_count는_10이다() {
        //given
        let data: BoxOffice = try! sut.decodeJSON(fileName: "box_office_sample")
        let expectation = 10
        
        //when
        let result = data.boxOfficeResult.dailyBoxOfficeList.count
        
        //then
        XCTAssertEqual(expectation, result)
    }
    
    func test_decoding에_성공한_boxOffice의_dailyBoxOfficeList의_첫번째영화는_경관의피이고_마지막영화는_엔칸토마법의세계이다() {
        //given
        let data: BoxOffice = try! sut.decodeJSON(fileName: "box_office_sample")
        let firstExpectation = "경관의 피"
        let lastExpectation = "엔칸토: 마법의 세계"
        
        //when
        let firstResult = data.boxOfficeResult.dailyBoxOfficeList.first?.movieName
        let lastResult = data.boxOfficeResult.dailyBoxOfficeList.last?.movieName
        
        //then
        XCTAssertEqual(firstExpectation, firstResult)
        XCTAssertEqual(lastExpectation, lastResult)
    }
}
