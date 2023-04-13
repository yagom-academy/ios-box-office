//
//  NetworkManagerTests.swift
//  NetworkManagerTests
//
//  Created by 리지, kokkilE on 2023/03/23.
//

import XCTest
@testable import BoxOffice
final class NetworkManagerTests: XCTestCase {
    var sut: NetworkManager!
    var expectation: XCTestExpectation!
    var boxOfficeEndPoint: BoxOfficeEndPoint!
    
    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        sut = NetworkManager(urlSession: urlSession)
        
        boxOfficeEndPoint = BoxOfficeEndPoint.DailyBoxOffice(tagetDate: "20230320")
        
        expectation = expectation(description: "Expectation")
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_request호출시_error가nil이아니면_unknownError가발생한다() {
        // given
        guard let data = NSDataAsset(name: "box_office_sample")?.data,
              let url: URL = boxOfficeEndPoint.createURL() else { return }
        
        MockURLProtocol.requestHandler = { request in
            
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            
            return (data, response, NetworkError.unknown)
        }
        
        let expectedResult = NetworkError.unknown.description
        
        // when
        sut.request(endPoint: boxOfficeEndPoint, returnType: DailyBoxOffice.self) { (result) in
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
        guard let data = NSDataAsset(name: "box_office_sample")?.data,
              let url: URL = boxOfficeEndPoint.createURL() else { return }
        
        MockURLProtocol.requestHandler = { request in
            
            let response = URLResponse(url: url, mimeType: "test", expectedContentLength: -1, textEncodingName: nil)
            
            return (data, response, nil)
        }
        
        let expectedResult = NetworkError.httpResponse.description
        
        // when
        sut.request(endPoint: boxOfficeEndPoint, returnType: DailyBoxOffice.self) { (result) in
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
        guard let data = NSDataAsset(name: "box_office_sample")?.data,
              let url: URL = boxOfficeEndPoint.createURL() else { return }
        
        MockURLProtocol.requestHandler = { request in
            
            let response = HTTPURLResponse(url: url, statusCode: 400, httpVersion: nil, headerFields: nil)
            
            return (data, response, nil)
        }
        
        let expectedResult = NetworkError.httpStatusCode(code: 400).description
        
        // when
        sut.request(endPoint: boxOfficeEndPoint, returnType: DailyBoxOffice.self) { (result) in
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
    
    func test_request호출시_data가nil이아니라면_case_success가실행된다() {
        // given
        guard let data = NSDataAsset(name: "box_office_sample")?.data,
              let url: URL = boxOfficeEndPoint.createURL() else { return }
        
        MockURLProtocol.requestHandler = { request in
            
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            
            return (data, response, nil)
        }
        
        let expectedResult = "경관의 피"
        
        // when
        sut.request(endPoint: boxOfficeEndPoint, returnType: DailyBoxOffice.self) { (result) in
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
