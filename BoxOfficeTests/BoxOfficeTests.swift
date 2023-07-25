//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by Serena, BMO on 2023/07/25.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    var sut: BoxOffice!
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = JSONDecoder.decode(fileName: "box_office_sample")
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_box_office_sample을_Decode하면_BoxOfficeResult_인스턴스가_존재한다() {
        // Given
        
        // When
        
        // Then
        XCTAssertNotNil(sut.boxOfficeResult)
    }
}
