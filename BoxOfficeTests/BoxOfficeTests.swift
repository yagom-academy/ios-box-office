//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by karen on 2023/07/26.
//

import XCTest

@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    private var sut: BoxOfficeDecoder<DailyBoxOffice>!
    private var model: MockNetworkModel!
    private var url = URL(apiType: KobisAPIType.boxOffice("20230804"))
    
    private var nsDataAsset:Data {
        return NSDataAsset(name: "box_office_sample")!.data
    }
    
    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        
        model = MockNetworkModel(session: session)
        sut = BoxOfficeDecoder(apiType: .boxOffice("20230804"), model: model)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        model = nil
    }
   
    func test_decode_성공했을_때_movies_개수가_10개이다() {
        // given
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url,
                  url == self.url else {
                throw BoxOfficeError.urlError
            }
            
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "2.0", headerFields: nil)!
            let data = self.nsDataAsset
            
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
    
    func test_URLResponse가_200번대면_Data타입을_받아온다() {
        // given
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url,
                  url == URL(apiType: KobisAPIType.boxOffice("20230804"))! else {
                throw BoxOfficeError.urlError
            }
            
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "2.0", headerFields: nil)!
            let data = self.nsDataAsset
            
            return (response, data)
        }
        
        let expectation = self.nsDataAsset
        let asyncTest = XCTestExpectation()
        let url = URL(apiType: KobisAPIType.boxOffice("20230804"))!
        
        // when
        model.getRequest(url: url) { result in
            switch result {
            case .success(let data):
                // then
                XCTAssertEqual(expectation, data)
                asyncTest.fulfill()
            case .failure(let error):
                print("error: \(error)")
                XCTFail("잘못된 테스트코드 입니다.")
            }
        }
        
        wait(for: [asyncTest], timeout: 3)
    }
    
    func test_URLResponse가_200번대가_아니라면_실패했다는_오류메세지를_나타낸다() {
        // given
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url,
                  url == URL(apiType: KobisAPIType.boxOffice("20230804"))! else {
                throw BoxOfficeError.urlError
            }
            
            let response = HTTPURLResponse(url: url, statusCode: 400, httpVersion: "2.0", headerFields: nil)!
            let data = self.nsDataAsset
            
            return (response, data)
        }
        
        let asyncTest = XCTestExpectation()
        let url = URL(apiType: KobisAPIType.boxOffice("20230804"))!
        
        // when
        model.getRequest(url: url) { event in
            switch event {
            case .success(_):
                XCTFail("잘못된 테스트코드입니다.")
            case .failure(let error):
                // then
                XCTAssertEqual(error, BoxOfficeError.responseFail)
                asyncTest.fulfill()
            }
        }
        
        wait(for: [asyncTest], timeout: 3)
    }
}
