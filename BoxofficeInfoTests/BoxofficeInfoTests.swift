//
//  BoxofficeInfoTests.swift
//  BoxofficeInfoTests
//
//  Created by Andrew, 레옹아범 on 2023/03/22.
//

import XCTest
@testable import BoxOffice

final class BoxofficeInfoTests: XCTestCase {
    
    var sut: MockBoxofficeInfo<DailyBoxofficeObject>!
    var mockSession = MockURLSession()
    
    override func setUpWithError() throws {
        sut = MockBoxofficeInfo(session: mockSession)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        mockSession.isDeny = false
    }
    
    func test_boxofficeType값은_일별_박스오피스이다() {
        // given
        let expectation = "일별 박스오피스"
        // when
        // then
        sut.search { event in
            switch event {
            case .success(let data):
                let result = data.boxOfficeResult.boxofficeType
                XCTAssertEqual(expectation, result)
            case .failure(let error):
                XCTAssertThrowsError(error)
            }
        }
    }
    
    func test_dailyBoxOfficeList의_요소갯수가_10개이다() {
        // given
        let expectation = 10
        // when
        // then
        sut.search { event in
            switch event {
            case .success(let data):
                let result = data.boxOfficeResult.movies.count
                XCTAssertEqual(expectation, result)
            case .failure(let error):
                XCTAssertThrowsError(error)
            }
        }
    }
    
    func test_URL세션을_찾지못하였다() {
        // given
        let expectation = BoxofficeError.responseError
        
        // when
        mockSession.isDeny = true
        
        // then
        sut.search { event in
            switch event {
            case .success(let data):
                XCTAssertNil(data)
            case .failure(let result):
                XCTAssertEqual(result, expectation)
            }
        }
        
    }
    
    
}
