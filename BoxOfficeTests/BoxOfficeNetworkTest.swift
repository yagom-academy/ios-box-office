//
//  BoxOfficeNetworkTest.swift
//  BoxOfficeTests
//
//  Created by Yetti, Maxhyunm on 2023/07/28.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeNetworkTest: XCTestCase {
    var sut: NetworkingManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        guard let asset = NSDataAsset(name: "movie_detail_sample") else {
            return
        }
        
        let url = URL(string: "https://www.naver.com/")!
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let dummy = DummyResponse(data: asset.data, response: response, error: nil)
        let stubSession = StubURLSession(dummy)
        
        sut = NetworkingManager(stubSession)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_MovieDetail_네트워킹이_성공했을때_데이터가_정상적으로_호출되는지() {
        // given
        let expectation = "광해, 왕이 된 남자"
        
        // when & then
        sut.load("") { (result: Result<Data, BoxOfficeError>) in
            switch result {
            case .success(let data):
                guard let decodedData: MovieDetailEntity = DecodingManager.shared.decode(data) else {
                    return
                }
                XCTAssertEqual(expectation, decodedData.movieInformationResult.movieInformation.movieName)
            case .failure:
                return
            }
        }
    }
    
    func test_MovieDetail_네트워킹이_실패했을때_에러가_반환되는지() {
        // given
        let expectation = "서버 응답 오류입니다. Status Code: 400"
        let url = URL(string: "https://www.naver.com/")!
        let response = HTTPURLResponse(url: url, statusCode: 400, httpVersion: nil, headerFields: nil)
        let dummy = DummyResponse(data: nil, response: response, error: nil)
        let stubSession = StubURLSession(dummy)
        
        sut = NetworkingManager(stubSession)
        
        // when & then
        sut.load("") { (result: Result<Data, BoxOfficeError>) in
            switch result {
            case .success:
                return
            case .failure(let error):
                XCTAssertEqual(expectation, error.description)
            }
        }
    }
}

