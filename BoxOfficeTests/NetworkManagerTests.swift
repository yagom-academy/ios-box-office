//
//  NetworkManagerTests.swift
//  BoxOfficeTests
//
//  Created by Christy, Hyemory on 2023/03/23.
//

import XCTest
@testable import BoxOffice

final class NetworkManagerTests: XCTestCase {
    var url: String!
    var data: Data!
    
    override func setUpWithError() throws {
        url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=20120101"
        data = NSDataAsset(name: "box_office_sample")!.data
    }

    override func tearDownWithError() throws {
        url = nil
        data = nil
    }
    
    func test_mockURLSession의_statusCode가_200일때_fetchData에_성공한_dailyBoxOfficeList의_첫번째_영화제목이_FileDecoder결과와_같다() {
        // given
        let mockURLSession = MockURLSession.make(url: url, data: data, statusCode: 200)
        let sut = NetworkManager(session: mockURLSession)
        let expectation: BoxOffice? = try? NetworkDecoder().decode(data: NSDataAsset(name: "box_office_sample")!.data,
                                                                    type: BoxOffice.self).get()
        
        // when
        var result: BoxOffice?
        sut.fetchData(url: URL(string: url), type: BoxOffice.self) { response in
            if case let .success(boxOffice) = response {
                result = boxOffice
            }
        }
        
        // then
        XCTAssertEqual(result?.result.dailyBoxOfficeList.first?.movieName,
                       expectation?.result.dailyBoxOfficeList.first?.movieName)
    }
    
    func test_잘못정의한Model로_fetchData호출시_decodeFailed에러를던진다() {
        // given
        let mockURLSession = MockURLSession.make(url: url, data: data, statusCode: 200)
        let sut = NetworkManager(session: mockURLSession)
        let expectation = NetworkingError.dataNotFound
        var result: NetworkingError?
        
        // when
        sut.fetchData(url: URL(string: url), type: DummyBoxOffice.self) { response in
            if case let .failure(error) = response {
                result = error as? NetworkingError
            }
        }
        
        // then
        XCTAssertEqual(result, expectation)
    }
    
    func test_mockURLSession의_statusCode가_400일때_clientError를던진다() {
        // given
        let mockURLSession = MockURLSession.make(url: url, data: data, statusCode: 400)
        let sut = NetworkManager(session: mockURLSession)
        let expectation = NetworkingError.clientError
        var result: NetworkingError?
        
        // when
        sut.fetchData(url: URL(string: url), type: DummyBoxOffice.self) { response in
            if case let .failure(error) = response {
                result = error as? NetworkingError
            }
        }
        
        // then
        XCTAssertEqual(result, expectation)
    }
    
    func test_mockURLSession의_statusCode가_500일때_serverError를던진다() {
        // given
        let mockURLSession = MockURLSession.make(url: url, data: data, statusCode: 500)
        let sut = NetworkManager(session: mockURLSession)
        let expectation = NetworkingError.serverError
        var result: NetworkingError?
        
        // when
        sut.fetchData(url: URL(string: url), type: DummyBoxOffice.self) { response in
            if case let .failure(error) = response {
                result = error as? NetworkingError
            }
        }
        
        // then
        XCTAssertEqual(result, expectation)
    }
}
