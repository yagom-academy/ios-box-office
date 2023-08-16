//
//  BoxOfficeNetworkTest.swift
//  BoxOfficeTests
//
//  Created by Yetti, Maxhyunm on 2023/07/28.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeNetworkingTest: XCTestCase {
    var sut: NetworkingManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        setUpSUT(isSuccess: true, apiType: NetworkConfiguration.movieDetail(""))
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func setUpSUT(isSuccess: Bool, apiType: NetworkConfiguration) {
        var urlString = ""
        var asset = ""
        
        switch apiType {
        case .boxOffice:
            urlString = NetworkConfiguration.boxOffice("20230801").url
            asset = "box_office_sample"
        case .movieDetail:
            urlString = NetworkConfiguration.movieDetail("20230801").url
            asset = "movie_detail_sample"
        case .daumImage:
            urlString = String(format: NetworkConfiguration.daumImage("").url)
            asset = "daum_image_sample"
        }

        let url = URL(string: urlString)!
        
        if isSuccess {
            let asset = NSDataAsset(name: asset)!
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            let dummy = DummyResponse(data: asset.data, response: response, error: nil)
            let stubSession = StubURLSession(dummy)

            sut = NetworkingManager(stubSession)
        } else {
            let response = HTTPURLResponse(url: url, statusCode: 400, httpVersion: nil, headerFields: nil)
            let dummy = DummyResponse(data: nil, response: response, error: nil)
            let stubSession = StubURLSession(dummy)

            sut = NetworkingManager(stubSession)
        }
    }
    
    func test_MovieDetail_네트워킹이_성공했을때_데이터가_정상적으로_호출되는지() {
        // given
        setUpSUT(isSuccess: true, apiType: NetworkConfiguration.movieDetail("20230801"))
        
        let expectation = "광해, 왕이 된 남자"
        
        // when & then
        sut.load(NetworkConfiguration.movieDetail("20230801")) { (result: Result<Data, NetworkingError>) in
            switch result {
            case .success(let data):
                do {
                    guard let decodedData: MovieDetailEntity = try DecodingManager.shared.decode(data) else {
                        XCTFail("테스트 실패")
                        return
                    }
                    XCTAssertEqual(expectation, decodedData.movieDetailData.movieInformation.movieName)
                } catch {
                    XCTFail("테스트 실패")
                }
            case .failure:
                XCTFail("테스트 실패")
            }
        }
    }
    
    func test_MovieDetail_네트워킹이_실패했을때_에러가_반환되는지() {
        // given
        setUpSUT(isSuccess: false, apiType: NetworkConfiguration.movieDetail("20230801"))
        
        let expectation = "서버 응답 오류입니다. Status Code: 400"
        
        // when & then
        sut.load(NetworkConfiguration.movieDetail("20230801")) { (result: Result<Data, NetworkingError>) in
            switch result {
            case .success:
                XCTFail("테스트 실패")
            case .failure(let error):
                XCTAssertEqual(expectation, error.description)
            }
        }
    }
    
    func test_DaumImage_네트워킹이_성공했을때_데이터가_정상적으로_호출되는지() {
        // given
        setUpSUT(isSuccess: true, apiType: NetworkConfiguration.daumImage(""))
        
        let expectation = "https://t1.daumcdn.net/cafeattach/1IHuH/f7f31ed51da240282d463ad00ef2c274d167de7a"
        
        // when & then
        sut.load(NetworkConfiguration.daumImage("")) { (result: Result<Data, NetworkingError>) in
            switch result {
            case .success(let data):
                do {
                    let decodedData: DaumImageEntity = try DecodingManager.shared.decode(data)
                    XCTAssertEqual(expectation, decodedData.documents.first?.imageURL)
                } catch {
                    XCTFail("테스트 실패")
                }
            case .failure:
                XCTFail("테스트 실패")
            }
        }
    }
}

