//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by Serena, BMO on 2023/07/25.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    var sut: BoxOffice?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_box_office_sample_json_파일을_디코딩_할_수_있다() {
        // Given
        do {
            // When
            let result: BoxOffice = try JSONDecoder.decode(fileName: "box_office_sample")
            
            // Then
            XCTAssertNotNil(result)
        } catch JSONDecoderError.notFoundedAssetFileName {
            XCTFail("JSON 파일을 부르는데 실패하였습니다.")
        } catch JSONDecoderError.failureDataDecoding {
            XCTFail("디코딩에 실패하였습니다.")
        } catch {
            XCTFail("알 수 없는 에러가 발생했습니다.")
        }
    }
}
