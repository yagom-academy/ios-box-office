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
        // given
        let expectedResult = try? JSONDecoder().decode(BoxOffice.self, from: SampleData.boxOfficeData!)
        let url = BoxOfficeEndPoint.fetchDailyBoxOffice(targetDate: "20120101").createURL()
        
        // when, then
        sut.getData(url: url, type: BoxOffice.self) { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(expectedResult?.boxOfficeResult.type, data.boxOfficeResult.type)
            case .failure:
                XCTFail()
            }
        }
    }
    
    func test_getData_호출시_BoxOffice_sample_data_불러오기에_실패한다() {
        // given
        let makeRequestFail = true
        sut = .init(session: MockURLSession(makeRequestFail: makeRequestFail))
        let expectedResult = "status: 410"
        let url = BoxOfficeEndPoint.fetchDailyBoxOffice(targetDate: "20120101").createURL()
        
        // when, then
        sut.getData(url: url, type: BoxOffice.self) { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(expectedResult, error.localizedDescription)
            }
        }
    }
}
