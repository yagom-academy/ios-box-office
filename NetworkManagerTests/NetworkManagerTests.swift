//
//  NetworkManagerTests.swift
//  NetworkManagerTests
//
//  Created by Rhode, Rilla on 2023/03/23.
//

import XCTest
@testable import BoxOffice

final class NetworkManagerTests: XCTestCase {
    var sut: NetworkManager!

    override func setUpWithError() throws {
        sut = NetworkManager(session: MockURLSession())
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_() {
        //given
        let session = MockURLSession(makeRequestFail: true)
        sut = NetworkManager(session: session)
        
        //when
        let expectation = XCTestExpectation()
        let testURL = URLMaker().makeBoxOfficeURL(date: Date.currentDate)
        
        sut.startLoad(url: testURL!) { result in
            //then
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, NetworkError.responseCodeError.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
}
