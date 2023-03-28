//
//  BoxofficeInfoTests.swift
//  BoxofficeInfoTests
//
//  Created by Andrew, 레옹아범 on 2023/03/28.
//

import XCTest
@testable import BoxOffice

final class BoxofficeInfoTests: XCTestCase {
    
    private var sut: BoxofficeInfo<DailyBoxofficeObject>!
    private var model: MockNetworkModel!
    private var url = APIType.boxoffice("20230322").receiveUrl()!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocolObject.self]
        let session = URLSession(configuration: configuration)
        
        model = MockNetworkModel(session: session)
        sut = BoxofficeInfo(apiType: .boxoffice("20230322"), model: model)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        model = nil
    }
    
    func test_성공한_URLResponse를_가질때_validateSuccessTask가_성공한다() {
        // given
        MockURLProtocolObject.requestHandler = { request in
            guard let url = request.url,
                  url == self.url else {
                throw BoxofficeError.urlError
            }
            
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "2.0", headerFields: nil)!
            let data = StubBoxoffice().data
            
            return (response, data)
        }
        
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "2.0", headerFields: nil)!
        let asyncTest = XCTestExpectation()
        
        // when
        sut.fetchData { event in
            switch event {
            case .success(_):
                asyncTest.fulfill()
            case .failure(_):
                XCTFail("잘못된 테스트코드입니다.")
            }
        }

        wait(for: [asyncTest], timeout: 3)
        
        // then
        model.vaildateSuccessTask(data: StubBoxoffice().data, httpResponse: response, callCount: 1)
    }
    
    func test_실패한_URLResponse를_가질때_validateFailureTask가_성공한다() {
        // given
        MockURLProtocolObject.requestHandler = { request in
            guard let url = request.url,
                  url == self.url else {
                throw BoxofficeError.urlError
            }
            
            let response = HTTPURLResponse(url: url, statusCode: 403, httpVersion: "2.0", headerFields: nil)!
            let data = Data()
            
            return (response, data)
        }
        
        var expectationError: BoxofficeError?
        let response = HTTPURLResponse(url: url, statusCode: 403, httpVersion: "2.0", headerFields: nil)!
        let asyncTest = XCTestExpectation()
        
        // when
        sut.fetchData { event in
            switch event {
            case .success(_):
                XCTFail("잘못된 테스트코드입니다.")
            case .failure(let error):
                expectationError = error
                asyncTest.fulfill()
            }
        }
        
        wait(for: [asyncTest], timeout: 3)
        
        model.validateFailureTask(httpResponse: response, callCount: 1, error: expectationError)
    }
    
    func test_decode를_성공했을시_movies_개수가_10개이다() {
        // given
        MockURLProtocolObject.requestHandler = { request in
            guard let url = request.url,
                  url == self.url else {
                throw BoxofficeError.urlError
            }
            
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "2.0", headerFields: nil)!
            let data = StubBoxoffice().data
            
            return (response, data)
        }
        
        let asyncTest = XCTestExpectation()
        let expectation = 10
        
        // when
        sut.fetchData { event in
            switch event {
            case .success(let data):
                // then
                asyncTest.fulfill()
                XCTAssertEqual(data.boxOfficeResult.movies.count, expectation)
            case .failure(_):
                XCTFail("잘못된 테스트코드입니다.")
            }
        }
    
        wait(for: [asyncTest], timeout: 3)
    }
}
