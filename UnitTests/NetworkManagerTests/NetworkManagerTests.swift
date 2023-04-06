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

    func test_fetchData_호출시_BoxOffice_sample_data_불러오기에_성공한다() {
        // given
        let expectedResult = try? JSONDecoder().decode(BoxOffice.self, from: SampleData.boxOfficeData!)
        let request = BoxOfficeEndpoint.fetchDailyBoxOffice(targetDate: "20120101").createRequest()
        
        // when, then
        sut.fetchData(request: request, type: BoxOffice.self) { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(expectedResult?.boxOfficeResult.type, data.boxOfficeResult.type)
            case .failure:
                XCTFail()
            }
        }
    }
    
    func test_fetchData_호출시_BoxOffice_sample_data_불러오기에_실패한다() {
        // given
        let makeRequestFail = true
        sut = .init(session: MockURLSession(makeRequestFail: makeRequestFail))
        let expectedResult = "status: 410"
        let request = BoxOfficeEndpoint.fetchDailyBoxOffice(targetDate: "20120101").createRequest()
        
        // when, then
        sut.fetchData(request: request, type: BoxOffice.self) { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(expectedResult, error.localizedDescription)
            }
        }
    }
    
    func test_fetchData_호출에_넘겨준_request와_session의_request가_동일하다() {
        // given
        let request = BoxOfficeEndpoint.fetchDailyBoxOffice(targetDate: "20120101").createRequest()
        
        // when
        let session = MockURLSession()
        sut = .init(session: session)
        sut.fetchData(request: request, type: BoxOffice.self) { _ in return }
        
        // then
        XCTAssertEqual(request, session.request)
    }
    
    func test_fetchData_호출시_session의_dataTask는_1번_호출된다() {
        // given
        let request = BoxOfficeEndpoint.fetchDailyBoxOffice(targetDate: "20120101").createRequest()
        let expectedResult = 1
        
        // when
        let session = MockURLSession()
        sut = .init(session: session)
        sut.fetchData(request: request, type: BoxOffice.self) { _ in return }
        
        // then
        XCTAssertEqual(expectedResult, session.dataTaskCallCount)
    }
    
    func test_fetchData_호출시_sessionDataTask의_resume이_1번_호출된다() {
        // given
        let request = BoxOfficeEndpoint.fetchDailyBoxOffice(targetDate: "20120101").createRequest()
        let expectedResult = 1
        
        // when
        let session = MockURLSession()
        sut = .init(session: session)
        sut.fetchData(request: request, type: BoxOffice.self) { _ in return }
        
        // then
        XCTAssertEqual(expectedResult, session.sessionDataTask.resumeCallCount)
    }
}
