//
//  DataManagerTests.swift
//  DataManagerTests
//
//  Created by Muri, Rowan on 2023/03/20.
//

import XCTest
@testable import BoxOffice

final class DataManagerTests: XCTestCase {
    var sut: APIProvider!
    
    override func setUpWithError() throws {
        sut = APIProvider(urlSession: MockURLSession())
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_startLoadDailyBoxOffice호출시_date로20230101을받을때_네트워킹이_성공한경우() {
        // given
        let expectedResult = try? JSONDecoder().decode(DailyBoxOffice.self, from: KobisAPI.dailyBoxOffice.sampleData)
        let date = "20230101"
        
        // when
        sut.startLoadDailyBoxOffice(date: date) { result in
            
            // then
            switch result {
            case .success(let dailyBoxOffice):
                XCTAssertEqual(dailyBoxOffice.boxOfficeResult.boxOfficeType, expectedResult?.boxOfficeResult.boxOfficeType)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func test_startLoadDailyBoxOffice호출시_request가_실패한경우() {
        // given
        let expectedResult = NetworkError.request.localizedDescription
        sut = APIProvider(urlSession: MockURLSession(makeRequestFail: true))
        let date = "20230101"
        
        // when
        sut.startLoadDailyBoxOffice(date: date) { result in
            
            // then
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, expectedResult)
            }
        }
    }
    
    func test_startLoadDailyBoxOffice호출시_server에러가_발생한경우() {
        // given
        let expectedResult = NetworkError.server.localizedDescription
        sut = APIProvider(urlSession: MockURLSession(makeServerError: true))
        let date = "20230101"
        
        // when
        sut.startLoadDailyBoxOffice(date: date) { result in
            
            // then
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, expectedResult)
            }
        }
    }
    
    func test_startLoadMovieDetails호출시_code로20199882을받을때_네트워킹이_성공한경우() {
        // given
        let expectedResult = try? JSONDecoder().decode(MovieDetails.self, from: KobisAPI.movieDetails.sampleData)
        sut = APIProvider(urlSession: MockURLSession(kobisAPI: .movieDetails))
        let code = "20199882"
        
        // when
        sut.startLoadMovieDetails(code: code) { result in
            
            // then
            switch result {
            case .success(let movieDetails):
                XCTAssertEqual(movieDetails.movieInfoResult.movieInfo.movieName,
                               expectedResult?.movieInfoResult.movieInfo.movieName)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func test_startLoadDailyBoxOfficeData호출시_request가_실패한경우() {
        // given
        let expectedResult = NetworkError.request.localizedDescription
        sut = APIProvider(urlSession: MockURLSession(makeRequestFail: true, kobisAPI: .movieDetails))
        let code = "20199882"
        
        // when
        sut.startLoadMovieDetails(code: code) { result in
            
            // then
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, expectedResult)
            }
        }
    }
    
    func test_startLoadDailyBoxOfficeData호출시_server에러가_발생한경우() {
        // given
        let expectedResult = NetworkError.server.localizedDescription
        sut = APIProvider(urlSession: MockURLSession(makeServerError: true, kobisAPI: .movieDetails))
        let code = "20199882"
        
        // when
        sut.startLoadMovieDetails(code: code) { result in
            
            // then
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, expectedResult)
            }
        }
    }
}
