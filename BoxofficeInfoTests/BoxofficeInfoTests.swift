//
//  BoxofficeInfoTests.swift
//  BoxofficeInfoTests
//
//  Created by Andrew, 레옹아범 on 2023/03/22.
//

import XCTest
@testable import BoxOffice

final class BoxofficeInfoTests: XCTestCase {
    
    private var sut: BoxofficeInfo<DailyBoxofficeObject>!
    
    override func setUpWithError() throws {
        sut = BoxofficeInfo(apiType: .boxoffice("20230320"), session: .shared )
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_boxofficeType값은_일별_박스오피스이다() {
        // given
        let expectation = "일별 박스오피스"
        // when
        sut.search { event in
            switch event {
            case .success(let data):
                let result = data.boxOfficeResult.boxofficeType
                XCTAssertEqual(expectation, result)
        // then
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
    
    func test_Session이_실패할경우_responseError를_반환한다() {
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
    
    func test_네트워크가_연결이되어있을경우_dailyBoxOfficeList의_요소갯수가_10개이고_안되어있을경우_sessionerror를_반환한다() {
        // given
        let asyncTest = XCTestExpectation()
        
        let errorExpectation = BoxofficeError.sessionError
        let successExpectation = 10
        // when
        sut.session = URLSession.shared
        
        // then
        sut.search { event in
            switch event {
            case .success(let data):
                let result = data.boxOfficeResult.movies.count
                XCTAssertEqual(result, successExpectation)
            case .failure(let error):
                XCTAssertEqual(error, errorExpectation)
            }
            asyncTest.fulfill()
        }
        
        wait(for: [asyncTest], timeout: 10.0)
    }
}
