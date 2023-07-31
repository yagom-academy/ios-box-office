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
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        sut = nil
    }
    
    func test_startLoad로_data로드에_성공했을때_정상적인_데이터를_받아오는지_확인합니다() {
        guard let dataAsset = NSDataAsset(name: "box_office_sample") else {
            return
        }
        // given
        let expectation = expectation(description: "")
        let url = URL.makeKobisURL(Path.boxOffice, [])
        let data = dataAsset.data
        let response = HTTPURLResponse(url: url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let dummy = DummyData(data: data, response: response, error: nil)
        let stubURLSession = StubURLSession(dummy: dummy)
        sut = NetworkManager(urlSession: stubURLSession)
        
        // when
        sut?.getData(from: url, completion: { result in
            // then
            switch result {
            case .success(let data):
                XCTAssertEqual(data, dataAsset.data)
                expectation.fulfill()
            case .failure(_):
                break
            }
        })
        
        wait(for: [expectation], timeout: 3)
    }
    
    func test_urlSession이_dataTask의_응답으로_error를_던질때_getData가_networkFailed_error를_반환하는지_확인합니다() {
        // given
        let expectation = expectation(description: "")
        let url = URL.makeKobisURL(Path.boxOffice, [])
        let dummy = DummyData(data: nil, response: nil, error: NSError())
        let stubURLSession = StubURLSession(dummy: dummy)
        sut = NetworkManager(urlSession: stubURLSession)

        // when
        sut?.getData(from: url, completion: { result in
            // then
            switch result {
            case .success(_):
                break
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.networkFailed)
                expectation.fulfill()
            }
        })

        wait(for: [expectation], timeout: 3)
    }
    
    func test_response_statusCode가_200번대가_아닐때_getData가_requestFailed_error를_반환하는지_확인합니다() {
        guard let dataAsset = NSDataAsset(name: "box_office_sample") else {
            return
        }
        // given
        let expectation = expectation(description: "")
        let url = URL.makeKobisURL(Path.boxOffice, [])
        let data = dataAsset.data
        let response = HTTPURLResponse(url: url!, statusCode: 404, httpVersion: nil, headerFields: nil)
        let dummy = DummyData(data: data, response: response, error: nil)
        let stubURLSession = StubURLSession(dummy: dummy)
        sut = NetworkManager(urlSession: stubURLSession)
        
        // when
        sut?.getData(from: url, completion: { result in
            // then
            switch result {
            case .success(_):
                break
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.requestFailed)
                expectation.fulfill()
            }
        })
        
        wait(for: [expectation], timeout: 3)
    }
    
    func test_urlSession이_올바른_data를_가져오지_못했을_때_getData가_dataFailed_error를_반환하는지_확인합니다() {
        // given
        let expectation = expectation(description: "")
        let url = URL.makeKobisURL(Path.boxOffice, [])
        let response = HTTPURLResponse(url: url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let dummy = DummyData(data: nil, response: response, error: nil)
        let stubURLSession = StubURLSession(dummy: dummy)
        sut = NetworkManager(urlSession: stubURLSession)
        
        // when
        sut?.getData(from: url, completion: { result in
            // then
            switch result {
            case .success(_):
                break
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.dataFailed)
            }
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 3)
    }
     
    func test_잘못된_URL을_넣어줬을때_getData가_invalidURL_error을_반환하는지_확입합니다() {
        // given
        let stubURLSession = StubURLSession(dummy: nil)
        let invaildURL: URL? = URL.makeKobisURL("invalidPath", [])
        sut = NetworkManager(urlSession: stubURLSession)
        
        // when
        sut?.getData(from: invaildURL) { result in
            // then
            switch result {
            case .success(_):
                break
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.invalidURL)
            }
        }
    }
}
