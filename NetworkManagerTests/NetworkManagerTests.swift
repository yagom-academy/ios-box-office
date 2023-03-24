//
//  NetworkManagerTests.swift
//  BoxOffice
//
//  Created by vetto, brody on 23/03/22.
//

import XCTest
@testable import BoxOffice

final class NetworkManagerTests: XCTestCase {
    var url: String!
    var data: Data!
    
    override func setUpWithError() throws {
        url = "https://www.kobis.or.kr/"
        data = JsonLoader.loadJsonAsset(name: "box_office_sample")
    }

    override func tearDownWithError() throws {
        url = nil
        data = nil
    }
    
    func test_fetchData호출시_Data가_있고_statusCode가_200일때_정상적으로_디코딩한다() {
        //given
        let prototypeJson = JsonLoader.loadJsonAsset(name: "box_office_sample")!
        let expectation = try? JSONDecoder().decode(BoxOffice.self, from: prototypeJson)
        let mockURLSession = MockURLSession.make(url: url,
                                                 data: data,
                                                 statusCode: 200)
        
        let sut = NetworkManager(session: mockURLSession)
        
        //when
        var result: BoxOffice?
        sut.fetchData(for: URL(string:url)!,
                      type: BoxOffice.self) { response in
            if case let .success(boxOffice) = response {
                result = boxOffice
            }
        }
        
        // then
        XCTAssertEqual(
            result?.boxOfficeResult.dailyBoxOfficeList.count,
            expectation?.boxOfficeResult.dailyBoxOfficeList.count
        )
        
        XCTAssertEqual(
            result?.boxOfficeResult.boxOfficeType,
            expectation?.boxOfficeResult.boxOfficeType
        )
    }
    
    func test_fetchData호출시_statusCode가_400이상_500미만일때_요청에러이다() {
        // given
        let expectation = NetworkError.invalidRequestError
        let mockURLSession = MockURLSession.make(url: url,
                                                 data: data,
                                                 statusCode: 404)
        
        let sut = NetworkManager(session: mockURLSession)
        
        //when
        var result: Error?
        sut.fetchData(for: URL(string:url)!,
                      type: BoxOffice.self) { response in
            if case let .failure(error) = response {
                result = error
            }
        }
        
        // then
        XCTAssertEqual(expectation, result as? NetworkError)
    }
    
    func test_fetchData호출시_statusCode가_500이상_600미만일때_서버에러이다() {
        // given
        let expectation = NetworkError.invalidResponseError
        let mockURLSession = MockURLSession.make(url: url,
                                                 data: data,
                                                 statusCode: 500)
        
        let sut = NetworkManager(session: mockURLSession)
        
        //when
        var result: Error?
        sut.fetchData(for: URL(string:url)!,
                      type: BoxOffice.self) { response in
            if case let .failure(error) = response {
                result = error
            }
        }
        
        // then
        XCTAssertEqual(expectation, result as? NetworkError)
    }
    
    func test_fetchData호출시_Data에_대한_잘못된타입을_넘겼을때_디코딩에실패한다() {
        // given
        let expectation = NetworkError.failToParse
        let mockURLSession = MockURLSession.make(url: url,
                                                 data: data,
                                                 statusCode: 200)
        
        let sut = NetworkManager(session: mockURLSession)
        
        //when
        var result: Error?
        sut.fetchData(for: URL(string:url)!,
                      type: MovieInformation.self) { response in
            if case let .failure(error) = response {
                result = error
            }
        }
        
        // then
        XCTAssertEqual(expectation, result as? NetworkError)
    }
}
