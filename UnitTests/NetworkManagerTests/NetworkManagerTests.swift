//
//  NetworkManagerTests.swift
//  NetworkManagerTests
//
//  Created by kaki, harry on 2023/03/23.
//

import XCTest
@testable import BoxOffice

final class NetworkManagerTests: XCTestCase {
    var sut: NetworkManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = .init(session: MockURLSession())
    }

    func test_getData_호출시_BoxOffice_sample_data_불러오기에_성공한다() {
        let expectation = XCTestExpectation()
        let expectedResult = try? JSONDecoder().decode(BoxOffice.self, from: SampleData.boxOfficeData!)
        let url = BoxOfficeEndPoint.fetchDailyBoxOffice(targetDate: "20120101").createURL()
        
        sut.getData(url: url, type: BoxOffice.self) { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(expectedResult?.boxOfficeResult.boxOfficeType, data.boxOfficeResult.boxOfficeType)
            case .failure:
                XCTFail()
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_getData_호출시_BoxOffice_sample_data_불러오기에_실패한다() {
        let makeRequestFail = true
        sut = .init(session: MockURLSession(makeRequestFail: makeRequestFail))
        let expectation = XCTestExpectation()
        let expectedResult = "status: 410"
        let url = BoxOfficeEndPoint.fetchDailyBoxOffice(targetDate: "20120101").createURL()
        
        sut.getData(url: url, type: BoxOffice.self) { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(expectedResult, error.localizedDescription)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
}
