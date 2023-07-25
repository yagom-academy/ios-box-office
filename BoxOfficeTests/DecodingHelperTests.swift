//
//  DecodingHelperTests.swift
//  BoxOfficeTests
//
//  Created by redmango1446 on 2023/07/24.
//

import XCTest
@testable import BoxOffice

final class DecodingHelperTests: XCTestCase {
    var sut: JSONDecodingHelper<BoxOffice>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = JSONDecodingHelper()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_decode_dailyBoxOfficeList의_첫번째로_들어온_객체의_rank값은_1이다() {
        //given
        let input = try? sut.runDecoding(from: "box_office_sample")
        let expectation = "1"
        
        //when
        let result = input?.boxOfficeResult.dailyBoxOfficeList[0].rank
        
        //then
        XCTAssertEqual(expectation, result)
    }
}
