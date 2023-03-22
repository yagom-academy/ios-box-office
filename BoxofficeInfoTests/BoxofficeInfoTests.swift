//
//  BoxofficeInfoTests.swift
//  BoxofficeInfoTests
//
//  Created by Andrew, 레옹아범 on 2023/03/22.
//

import XCTest
@testable import BoxOffice

final class BoxofficeInfoTests: XCTestCase {
    
    var sut: BoxofficeInfo<DailyBoxofficeObject>!
    var mockSession = MockURLSession()

    override func setUpWithError() throws {
        sut = BoxofficeInfo(interfaceValue: "20230320", apiType: .boxoffice, session: mockSession)
    }

    override func tearDownWithError() throws {
        sut = nil
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
                print("expectation: \(expectation)")
            case .failure(let error):
                XCTAssertThrowsError(error)
                print("Error: \(error)")
            }
        }
        
    }
    
}
