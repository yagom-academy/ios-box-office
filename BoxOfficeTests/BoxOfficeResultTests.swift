//
//  BoxOfficeResultTests.swift
//  BoxOfficeTests
//
//  Created by Serena, BMO on 2023/07/25.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeResultTests: XCTestCase {
    var sut: BoxOfficeResult?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        guard let boxOffice: BoxOffice = JSONDecoder.decode(fileName: "box_office_sample") else { return }
        sut = boxOffice.boxOfficeResult
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_box_office_sample을_Decode하면_BoxOfficeResult_인스턴스가_존재한다() {
        // Given

        // When

        // Then
        XCTAssertNotNil(sut)
    }
    
    func test_boxOfficeType이_일별_박스오피스를_반환한다() {
        // Given
        let result = sut?.boxOfficeType
        
        // When
        let expectedResult: String = "일별 박스오피스"
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_dailyBoxOfficeList의_값이_있다() {
        // Given
        let result = sut?.dailyBoxOfficeList.isEmpty
        
        // When
        let expectedResult = false
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
}
