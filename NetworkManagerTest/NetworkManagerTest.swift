//
//  NetworkManagerTest.swift
//  NetworkManagerTest
//
//  Created by 리지, kokkilE on 2023/03/23.
//

import XCTest
@testable import BoxOffice
final class NetworkManagerTest: XCTestCase {
    var sut: MockNetworkManager!
    var expectation: XCTestExpectation!
    var endPoint = EndPoint()
    
    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        
        endPoint.setEndPoint(method: .get, body: nil, baseURL: "testURL", key: "testKey", targetDate: "test")
        sut = MockNetworkManager(urlSession: urlSession)
        expectation = expectation(description: "Expectation")
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_request호출시_error가nil이아니면_unknownError가발생한다() {
        // given
        guard let data = NSDataAsset(name: "box_office_sample")?.data else { return }
        
        MockURLProtocol.requestHandler = { [unowned self] request in
            
            let response = HTTPURLResponse(url: endPoint.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
            
            return (data, response, NetworkError.unknown)
        }
        
        let expectedResult = NetworkError.unknown.description
        
        // when
        sut.request(endPoint: endPoint, returnType: BoxOffice.self) { (result) in
            switch result {
            case .success(_):
                XCTFail("Success response was not expected.")
            case .failure(let error):
                // then
                XCTAssertEqual(error.description, expectedResult)
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    func test_request호출시_response가HTTPURLResponse타입이아니면_httpResponseError가발생한다() {
        // given
        guard let data = NSDataAsset(name: "box_office_sample")?.data else { return }
        
        MockURLProtocol.requestHandler = { [unowned self] request in
            
            let response = URLResponse(url: endPoint.url!, mimeType: "test", expectedContentLength: -1, textEncodingName: nil)
            
            return (data, response, nil)
        }
        
        let expectedResult = NetworkError.httpResponse.description
        
        // when
        sut.request(endPoint: endPoint, returnType: BoxOffice.self) { (result) in
            switch result {
            case .success(_):
                XCTFail("Success response was not expected.")
            case .failure(let error):
                // then
                XCTAssertEqual(error.description, expectedResult)
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    func test_request호출시_response의httpStatusCode가200번대가아니면_httpStatusCodeError가발생한다() {
        // given
        guard let data = NSDataAsset(name: "box_office_sample")?.data else { return }
        
        MockURLProtocol.requestHandler = { [unowned self] request in
            
            let response = HTTPURLResponse(url: endPoint.url!, statusCode: 400, httpVersion: nil, headerFields: nil)
            
            return (data, response, nil)
        }
        
        let expectedResult = NetworkError.httpStatusCode(code: 400).description
        
        // when
        sut.request(endPoint: endPoint, returnType: BoxOffice.self) { (result) in
            switch result {
            case .success(_):
                XCTFail("Success response was not expected.")
            case .failure(let error):
                // then
                XCTAssertEqual(error.description, expectedResult)
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    func test_request호출시_data가nil이아니라면_데이터파싱을성공한다() {
        // given
        guard let data = NSDataAsset(name: "box_office_sample")?.data else { return }
        
        MockURLProtocol.requestHandler = { [unowned self] request in
            
            let response = HTTPURLResponse(url: endPoint.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
            
            return (data, response, nil)
        }
        
        let expectedResult = "경관의 피"
        
        // when
        sut.request(endPoint: endPoint, returnType: BoxOffice.self) { (result) in
            switch result {
            case .success(let boxOffice):
                // then
                XCTAssertEqual(boxOffice.boxOfficeResult.boxOfficeList[0].name, expectedResult)
            case .failure(_):
                XCTFail("Failure response was not expected.")
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
}
