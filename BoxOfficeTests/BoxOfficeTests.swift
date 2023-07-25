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
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_box_office_sample_json_파일을_디코딩_할_수_있다() {
        // Given
        guard let result: BoxOffice = JSONDecoder.decode(fileName: "box_office_sample") else {
            XCTFail("파일명 'box_office_sample'로 JSON 디코딩 할 수 없습니다.")
            return
        }
        
        // When
        
        // Then
        XCTAssertNotNil(result)
    }
}
