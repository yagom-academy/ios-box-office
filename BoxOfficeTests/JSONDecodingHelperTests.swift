//
//  DecodingHelperTests.swift
//  BoxOfficeTests
//
//  Created by redmango1446 on 2023/07/24.
//

import XCTest
@testable import BoxOffice

final class JSONDecodingHelperTests: XCTestCase {
    var sut: JSONDecodingHelper<BoxOffice>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = JSONDecodingHelper()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_prase_dailyBoxOfficeList의_첫번째로_들어온_객체의_rank값은_1이다() {
        //given
        let input = try? sut.parse(from: "box_office_sample")
        let expectation = "1"
        
        //when
        let result = input?.boxOfficeResult.dailyBoxOfficeList[0].rank
        
        //then
        XCTAssertEqual(expectation, result)
    }
    func test_parse_잘못된파일이름으로_파싱하면_가져오는데이터가_nil값을_갖는다() {
        //given
        let input = try? sut.parse(from: "wrong_fileName")
        let expectation: String? = nil
        
        //when
        let result = input?.boxOfficeResult.dailyBoxOfficeList[0].movieCode
        
        //then
        XCTAssertEqual(expectation, result)
    }
}
