//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by Yetti, Maxhyunm on 2023/07/24.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    var sut: BoxOfficeEntity!

    override func setUpWithError() throws {
        try super.setUpWithError()
        guard let path = Bundle.main.path(forResource: "box_office_sample", ofType: "json"),
              let jsonString = try? String(contentsOfFile: path) else {
            return
        }
        let data = jsonString.data(using: .utf8)
        
        sut = DecodingManager.shared.decode(data)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_DecodingManager를_통해_parsing이_잘_이루어지는지_확인() {
        // given
        let boxOfficeTypeExpectation = "일별 박스오피스"
        let movieCodeExpectation = "20199882"
        
        // when
        let boxOfficeTypeResult = sut.boxOfficeResult.boxOfficeType
        let movieCodeResult = sut.boxOfficeResult.dailyBoxOfficeList[0].movieCode
        
        // then
        XCTAssertEqual(boxOfficeTypeExpectation, boxOfficeTypeResult)
        XCTAssertEqual(movieCodeExpectation, movieCodeResult)
    }
}
