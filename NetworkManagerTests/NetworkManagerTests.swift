//
//  NetworkManagerTests.swift
//  NetworkManagerTests
//
//  Created by kyungmin, Erick on 2023/07/26.
//

import XCTest
@testable import BoxOffice

final class NetworkManagerTests: XCTestCase {
    var sut: NetworkManager?
    
    override func setUpWithError() throws {
        sut = NetworkManager(urlSession: StubURLSession())
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_startLoad로_data로드에_성공했을때_정상적인_데이터를_받아오는지_확인합니다() {
        guard let dataAsset = NSDataAsset(name: "box_office_sample") else {
            return
        }
        // given
        let expectation = expectation(description: "")
        let url = sut?.configuredURL(scheme: Scheme.http, host: Host.kobis, path: Path.boxOffice, queryItems: [])
        let data = dataAsset.data
        let response = HTTPURLResponse(url: url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let dummy = DummyData(data: data, response: response, error: nil)
        let stubUrlSession = StubURLSession(dummy: dummy)
        
        sut?.urlSession = stubUrlSession
        
        // when
        sut?.startLoad(url!, completion: { data in
            // then
            XCTAssertEqual(data, dataAsset.data)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_response_statusCode가_200번대가_아닐때_데이터가_nil인지_확인합니다() {
        guard let dataAsset = NSDataAsset(name: "box_office_sample") else {
            return
        }
        // given
        let expectation = expectation(description: "")
        let url = sut?.configuredURL(scheme: Scheme.http, host: Host.kobis, path: Path.boxOffice, queryItems: [])
        let data = dataAsset.data
        let response = HTTPURLResponse(url: url!, statusCode: 404, httpVersion: nil, headerFields: nil)
        let dummy = DummyData(data: data, response: response, error: nil)
        let stubUrlSession = StubURLSession(dummy: dummy)
        
        sut?.urlSession = stubUrlSession
        
        // when
        sut?.startLoad(url!, completion: { data in
            // then
            XCTAssertEqual(data, nil)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_urlSession이_dataTask의_응답으로_error를_던질때_데이터가_nil인지_확인합니다() {
        // given
        let expectation = expectation(description: "")
        let url = sut?.configuredURL(scheme: Scheme.http, host: Host.kobis, path: Path.boxOffice, queryItems: [])
        let dummy = DummyData(data: nil, response: nil, error: NSError())
        let stubUrlSession = StubURLSession(dummy: dummy)
        
        sut?.urlSession = stubUrlSession
        
        // when
        sut?.startLoad(url!, completion: { data in
            // then
            XCTAssertEqual(data, nil)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 5)
    }
}
