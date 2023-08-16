//
//  DaumSearchEndPointTests.swift
//  DaumSearchEndPointTests
//
//  Created by Hyungmin Lee on 2023/08/16.
//

import XCTest
@testable import BoxOffice

final class DaumSearchEndPointTests: XCTestCase {
    private var sut: DaumSearchEndPoint!
    
    override func setUpWithError() throws {
        sut = DaumSearchEndPoint(.image(movieName: "밀수"))
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_영화이미지Data를_요청하는URL을_잘만들어주는지() {
        //given
        let expectation = URL(string: "https://dapi.kakao.com/v2/search/image?query=%EB%B0%80%EC%88%98%20%EC%98%81%ED%99%94%20%ED%8F%AC%EC%8A%A4%ED%84%B0")
        
        //when
        let result = sut.url
        
        //then
        XCTAssertEqual(expectation, result)
    }
}
