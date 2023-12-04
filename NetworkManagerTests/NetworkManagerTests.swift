//
//  NetworkManagerTests.swift
//  NetworkManagerTests
//
//  Created by Kiseok, jyubong
//

import XCTest
@testable import BoxOffice

final class NetworkManagerTests: XCTestCase {
    var sut: NetworkManager!
    private let api = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=20220105"
    var url: URL!
    var jsonData: Data!
    
    override func setUpWithError() throws {
        url = try XCTUnwrap(URL(string: api))
        jsonData = try XCTUnwrap(TestMovieJsonData.json.data(using: .utf8))
    }
    
    func test_fetchData_success() {
        // given
        TestURLProtocol.loadingHandler = { [self] request in
            let response = HTTPURLResponse(
                url: url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )
            return (jsonData, response, nil)
        }
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        
        sut = .init(urlSession: URLSession(configuration: configuration))
        
        // when
        sut.fetchData(url: api) { response in
            if case let .success(data) = response {
                let result = data
                
                XCTAssertEqual(self.jsonData, result)
            }
        }
    }
    
    func test_fetchData_response_failure() {
        // given
        TestURLProtocol.loadingHandler = { [self] request in
            let response = HTTPURLResponse(
                url: url,
                statusCode: 400,
                httpVersion: nil,
                headerFields: nil
            )
            return (jsonData, response, nil)
        }
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        
        sut = .init(urlSession: URLSession(configuration: configuration))
        
        let expectation = FetchError.invalidResponse
        
        // when
        sut.fetchData(url: api) { response in
            if case let .failure(error) = response {
                
                guard let result = error as? FetchError else {
                    XCTFail()
                    return
                }
                
                XCTAssertEqual(result, expectation)
            }
        }
    }
}

