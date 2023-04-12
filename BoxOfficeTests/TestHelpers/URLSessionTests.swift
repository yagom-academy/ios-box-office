//
//  URLTest.swift
//  BoxOfficeTests
//
//  Created by Seoyeon Hong on 2023/03/22.
//

import XCTest
@testable import BoxOffice

final class URLTest: XCTestCase {
    
    var boxOfficeURLString: String!
    var boxOfficeAPI: MovieAPI!
    var movieInfoAPI: MovieAPI!
    var boxOfficeData: Data!
    
    override func setUpWithError() throws {
        boxOfficeURLString = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=5946533a51615e4910d26ed447f2a666&targetDt=20220101"
        boxOfficeAPI = MovieAPI.boxOffice(date: "20220101")
        movieInfoAPI = MovieAPI.detail(code: "")
        
        boxOfficeData = NSDataAsset(name: "box_office_sample", bundle: .main)!.data
    }
    
    func test_performRequest_whenURLMismatch_expectClientError() {
        // given
        let mockURLSession = MockURLSession.create(with: boxOfficeURLString, data: nil, statusCode: 0)
        let sut = APIProvider(session: mockURLSession)
        
        // when then
        sut.performRequest(api: movieInfoAPI) { result in
            if case let .failure(error) = result {
                XCTAssertEqual(error, .clientError)
            } else {
                XCTAssertTrue(false)
            }
        }
    }
    
    func test_performRequest_whenURLMatch_expectSuccess() {
        // given
        let mockURLSession = MockURLSession.create(with: boxOfficeURLString, data: boxOfficeData, statusCode: 200)
        let sut = APIProvider(session: mockURLSession)
        
        // when then
        sut.performRequest(api: boxOfficeAPI) { result in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure:
                XCTAssertTrue(false)
            }
        }
    }
    
    func test_performRequest_whenDataExistsAndStatusCode200_expectBoxOfficeItemCount() {
        // given
        let expectation = try? JSONDecoder().decode(BoxOfficeItem.self, from: boxOfficeData)
        let mockURLSession = MockURLSession.create(with: boxOfficeURLString, data: boxOfficeData, statusCode: 200)
        let sut = APIProvider(session: mockURLSession)
        
        // when
        var item: BoxOfficeItem?
        sut.performRequest(api: boxOfficeAPI) { result in
            if case let .success(data) = result {
                item = try! JSONConverter.shared.decodeData(data, BoxOfficeItem.self)
            }
        }
        
        // then
        XCTAssertEqual(
            item?.boxOfficeResult.dailyBoxOfficeList.count,
            expectation?.boxOfficeResult.dailyBoxOfficeList.count
        )
    }
    
    func test_performRequest_whenDataExistsAndStatusCode200_expectFirstMovieName() {
        // given
        let expectation = try? JSONDecoder().decode(BoxOfficeItem.self, from: boxOfficeData)
        let mockURLSession = MockURLSession.create(with: boxOfficeURLString, data: boxOfficeData, statusCode: 200)
        let sut = APIProvider(session: mockURLSession)
        
        // when
        var item: BoxOfficeItem?
        sut.performRequest(api: boxOfficeAPI) { result in
            if case let .success(data) = result {
                item = try! JSONConverter.shared.decodeData(data, BoxOfficeItem.self)
            }
        }
        
        // then
        XCTAssertEqual(
            item?.boxOfficeResult.dailyBoxOfficeList.first?.movieTitle,
            expectation?.boxOfficeResult.dailyBoxOfficeList.first?.movieTitle
        )
    }
    
}
