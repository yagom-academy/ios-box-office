//
//  BoxofficeInfoTests.swift
//  BoxofficeInfoTests
//
//  Created by Andrew, 레옹아범 on 2023/03/22.
//

import XCTest
@testable import BoxOffice

final class BoxofficeInfoTests: XCTestCase {
    
    private var sut: NetworkModel<DailyBoxofficeObject>!
    
    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocolObject.self]
        
        let session = URLSession(configuration: configuration)
        
        sut = NetworkModel(apiType: .boxoffice("20230322"), session: session)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_URLResponse가_200번대라면_Data의_InfoObject는_10개이다() {
        // given
        MockURLProtocolObject.requestHandler = { request in
            guard let url = request.url,
                  url == APIType.boxoffice("20230322").receiveUrl()! else {
                throw BoxofficeError.urlError
            }
            
            let response = HTTPURLResponse(url: url, mimeType: "application/json", expectedContentLength: 0, textEncodingName: nil)
            let data = StubBoxoffice().data
            
            return (response, data)
        }
        
        let expectation = 10
        let asyncTest = XCTestExpectation()
        
        // when
        sut.search { event in
            switch event {
            case .success(let data):
                // then
                XCTAssertEqual(expectation, data.boxOfficeResult.movies.count)
                asyncTest.fulfill()
            case .failure(_):
                XCTFail("잘못된 테스트코드입니다.")
            }
        }
        
        wait(for: [asyncTest], timeout: 3)
    }
    
    func test_URLResponse가_200번대가_아니라면_responseError를_나타낸다() {
        // given
        MockURLProtocolObject.requestHandler = { request in
            guard let url = request.url,
                  url == APIType.boxoffice("20230322").receiveUrl() else {
                throw BoxofficeError.urlError
            }
            
            let response = HTTPURLResponse(url: url, statusCode: 400, httpVersion: "2.0", headerFields: nil)!
            let data = StubBoxoffice().data
            
            return (response, data)
        }
        
        let asyncTest = XCTestExpectation()
        
        // when
        sut.search { event in
            switch event {
            case .success(_):
                XCTFail("잘못된 테스트코드입니다.")
            case .failure(let error):
                // then
                XCTAssertEqual(error, BoxofficeError.responseError)
                asyncTest.fulfill()
            }
        }
        
        wait(for: [asyncTest], timeout: 3)
    }
    
    func test_mimeType의_형식이_잘못되었을경우_incorrectDataTypeError를_나타낸다() {
        // given
        MockURLProtocolObject.requestHandler = { request in
            guard let url = request.url,
                  url == APIType.boxoffice("20230322").receiveUrl() else {
                throw BoxofficeError.urlError
            }
            let response = HTTPURLResponse(url: url, mimeType: "application/octet-stream", expectedContentLength: 0, textEncodingName: nil)
            let data = StubBoxoffice().data
            
            return (response, data)
        }
        
        let asyncTest = XCTestExpectation()
        
        // when
        sut.search { event in
            switch event {
            case .success(_):
                XCTFail("잘못된 테스트코드입니다.")
            case .failure(let error):
                XCTAssertEqual(error, BoxofficeError.incorrectDataTypeError)
                asyncTest.fulfill()
            }
        }
        
        wait(for: [asyncTest], timeout: 3)
    }
    
}
