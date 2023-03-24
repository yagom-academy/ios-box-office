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
    
    override func setUpWithError() throws {
        sut = APIProvider(urlSession: MockURLSession())
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_startLoad호출시_decodingType이_DailyBoxOffice이고_target으로20230101을받을때_네트워킹이_성공한경우() {
        // given
        let expectedResult = try? JSONDecoder().decode(DailyBoxOffice.self, from: KobisAPI.Service.dailyBoxOffice.sampleData)
        let date = "20230101"
        
        // when
        sut.startLoad(decodingType: DailyBoxOffice.self, target: date) { result in
            
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
        sut = APIProvider(urlSession: MockURLSession(makeRequestFail: true))
        let date = "20230101"
        
        // when
        sut.startLoad(decodingType: DailyBoxOffice.self, target: date) { result in
            
            // then
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, expectedResult)
            }
        }
    }
    
    func test_startLoad호출시_decodingType이_DailyBoxOffice이고_server에러가_발생한경우() {
        // given
        let expectedResult = NetworkError.server.localizedDescription
        sut = APIProvider(urlSession: MockURLSession(makeServerError: true))
        let date = "20230101"
        
        // when
        sut.startLoad(decodingType: DailyBoxOffice.self, target: date) { result in
            
            // then
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, expectedResult)
            }
        }
    }
    
    func test_startLoad호출시_decodingType이_MovieDetails이고_target으로20199882을받을때_네트워킹이_성공한경우() {
        // given
        let expectedResult = try? JSONDecoder().decode(MovieDetails.self, from: KobisAPI.Service.movieDetails.sampleData)
        sut = APIProvider(urlSession: MockURLSession(kobisAPI: .init(currentService: .movieDetails)))
        let code = "20199882"
        
        // when
        sut.startLoad(decodingType: MovieDetails.self, target: code) { result in
            
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
        let expectedResult = NetworkError.request.localizedDescription
        sut = APIProvider(urlSession: MockURLSession(makeRequestFail: true, kobisAPI: .init(currentService: .movieDetails)))
        let code = "20199882"
        
        // when
        sut.startLoad(decodingType: MovieDetails.self, target: code) { result in
            
            // then
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, expectedResult)
            }
        }
    }
    
    func test_startLoad호출시_decodingType이_MovieDetails이고_server에러가_발생한경우() {
        // given
        let expectedResult = NetworkError.server.localizedDescription
        sut = APIProvider(urlSession: MockURLSession(makeServerError: true, kobisAPI: .init(currentService: .movieDetails)))
        let code = "20199882"
        
        // when
        sut.startLoad(decodingType: MovieDetails.self, target: code) { result in
            
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
