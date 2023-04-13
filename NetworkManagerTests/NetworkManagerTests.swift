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
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocolObject.self]
        let session = URLSession(configuration: configuration)
        
        sut = NetworkManager(session: session)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_20220105날짜의URL로요청시_서버에서_해당날짜의BoxOffice의Data를_넘겨준다() {
        //given
        MockURLProtocolObject.requestHandler = { (request: URLRequest )in
            guard let url = request.url, request == URLRequestMaker().makeBoxOfficeURLRequest(date: "20220105") else {
                throw NetworkError.invalidResponse
            }
    
            let data = DummyBoxOffice().data
            let responses = HTTPURLResponse(url: url,
                                            mimeType: "json",
                                            expectedContentLength: 0,
                                            textEncodingName: nil)
            
            return (responses, data)
        }
        
        let expectedResult = DummyBoxOffice().data
        let expectation = XCTestExpectation()
        guard let request = URLRequestMaker().makeBoxOfficeURLRequest(date: "20220105") else {
            return
        }
        
        //when
        sut.startLoad(request: request, mime: "json") { result in
            switch result {
            case .success(let successData):
                //then
                XCTAssertEqual(expectedResult, successData)
                expectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
                
        wait(for: [expectation], timeout: 3)
    }
    
    func test_20220105이_아닌날짜의URL로요청시_서버에서_error가_발생한다() {
        //given
        MockURLProtocolObject.requestHandler = { (request: URLRequest )in
            guard let url = request.url,
            request == URLRequestMaker().makeBoxOfficeURLRequest(date: "20220105") else {
                throw NetworkError.invalidResponse
            }
    
            let data = DummyBoxOffice().data
            let responses = HTTPURLResponse(url: url,
                                            mimeType: "json",
                                            expectedContentLength: 0,
                                            textEncodingName: nil)
            return (responses, data)
        }

        let expectation = XCTestExpectation()
        guard let request = URLRequestMaker().makeBoxOfficeURLRequest(date: "20220101") else {
            return
        }
        
        //when
        sut.startLoad(request: request, mime: "json") { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                //then
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
                
        wait(for: [expectation], timeout: 3)
    }
}
