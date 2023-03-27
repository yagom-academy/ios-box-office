//
//  APIProviderTests.swift
//  APIProviderTests
//
//  Created by Muri, Rowan on 2023/03/20.
//

import XCTest
@testable import BoxOffice

final class APIProviderTests: XCTestCase {
    var sut: APIProvider!
    var mockURLSession: MockURLSession!
    var kobisAPI = KobisAPI(service: .dailyBoxOffice)
    
    override func setUp() {
        mockURLSession = MockURLSession(kobisAPI: kobisAPI)
        sut = APIProvider(urlSession: mockURLSession)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_startLoad호출시_decodingType이_DailyBoxOffice이고_target으로20230101을받을때_네트워킹이_성공한경우() {
        // given
        let expectedResult = try? JSONDecoder().decode(DailyBoxOffice.self, from: kobisAPI.sampleData)
        let date = "20230101"
        let queryName = "targetDt"
        kobisAPI.addQuery(name: queryName, value: date)
        
        // when
        sut.startLoad(decodingType: DailyBoxOffice.self) { result in
            
            // then
            switch result {
            case .success(let dailyBoxOffice):
                XCTAssertEqual(dailyBoxOffice.boxOfficeResult.boxOfficeType, expectedResult?.boxOfficeResult.boxOfficeType)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func test_startLoad호출시_decodingType이_DailyBoxOffice이고_request가_실패한경우() {
        // given
        let expectedResult = NetworkError.request.localizedDescription
        sut = APIProvider(urlSession: MockURLSession(makeRequestFail: true, kobisAPI: kobisAPI))
        let date = "20230101"
        let queryName = "targetDt"
        kobisAPI.addQuery(name: queryName, value: date)
        
        // when
        sut.startLoad(decodingType: DailyBoxOffice.self) { result in
            
            // then
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, expectedResult)
            }
        }
    }
    
    func test_startLoad호출시_decodingType이_DailyBoxOffice이고_server에러가_발생한경우() {
        // given
        let expectedResult = NetworkError.server.localizedDescription
        sut = APIProvider(urlSession: MockURLSession(makeServerError: true, kobisAPI: kobisAPI))
        let date = "20230101"
        let queryName = "targetDt"
        kobisAPI.addQuery(name: queryName, value: date)
        
        // when
        sut.startLoad(decodingType: DailyBoxOffice.self) { result in
            
            // then
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, expectedResult)
            }
        }
    }
    
    func test_startLoad호출시_decodingType이_MovieDetails이고_target으로20199882을받을때_네트워킹이_성공한경우() {
        // given
        kobisAPI.service = .movieDetails
        let expectedResult = try? JSONDecoder().decode(MovieDetails.self, from: kobisAPI.sampleData)
        sut = APIProvider(urlSession: MockURLSession(kobisAPI: kobisAPI))
        let code = "20199882"
        let queryName = "movieCd"
        kobisAPI.addQuery(name: queryName, value: code)
        
        // when
        sut.startLoad(decodingType: MovieDetails.self) { result in
            
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
    
    func test_startLoad호출시_decodingType이_MovieDetails이고_request가_실패한경우() {
        // given
        kobisAPI.service = .movieDetails
        let expectedResult = NetworkError.request.localizedDescription
        sut = APIProvider(urlSession: MockURLSession(makeRequestFail: true, kobisAPI: kobisAPI))
        let code = "20199882"
        let queryName = "movieCd"
        kobisAPI.addQuery(name: queryName, value: code)
        
        // when
        sut.startLoad(decodingType: MovieDetails.self) { result in
            
            // then
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, expectedResult)
            }
        }
    }
    
    func test_startLoad호출시_decodingType이_MovieDetails이고_server에러가_발생한경우() {
        // given
        kobisAPI.service = .movieDetails
        let expectedResult = NetworkError.server.localizedDescription
        sut = APIProvider(urlSession: MockURLSession(makeServerError: true, kobisAPI: kobisAPI))
        let code = "20199882"
        let queryName = "movieCd"
        kobisAPI.addQuery(name: queryName, value: code)
        
        // when
        sut.startLoad(decodingType: MovieDetails.self) { result in
            
            // then
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, expectedResult)
            }
        }
    }
}
