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
        setUpSUT(isSuccess: true, apiType: NetworkNamespace.movieDetail)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func setUpSUT(isSuccess: Bool, apiType: NetworkNamespace) {
        var urlString = ""
        var asset = ""
        
        switch apiType {
        case .boxOffice:
            urlString = String(format: NetworkNamespace.boxOffice.url, NetworkNamespace.apiKey, "20230801")
            asset = "box_office_sample"
        case .movieDetail:
            urlString = String(format: NetworkNamespace.movieDetail.url, NetworkNamespace.apiKey, "20230801")
            asset = "movie_detail_sample"
        case .daumImage:
            urlString = String(format: NetworkNamespace.daumImage.url)
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
        setUpSUT(isSuccess: true, apiType: NetworkNamespace.movieDetail)
        
        let expectation = "광해, 왕이 된 남자"
        let request = URLRequest(url: URL(string: "https://www.naver.com/")!)
        
        // when & then
        sut.load(request) { (result: Result<Data, NetworkingError>) in
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
        setUpSUT(isSuccess: false, apiType: NetworkNamespace.movieDetail)
        
        let expectation = "서버 응답 오류입니다. Status Code: 400"
        let request = URLRequest(url: URL(string: "https://www.naver.com/")!)
        
        // when & then
        sut.load(request) { (result: Result<Data, NetworkingError>) in
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
        setUpSUT(isSuccess: true, apiType: NetworkNamespace.daumImage)
        
        let expectation = "https://t1.daumcdn.net/cafeattach/1IHuH/f7f31ed51da240282d463ad00ef2c274d167de7a"
        let request = URLRequest(url: URL(string: "https://www.naver.com/")!)
        
        // when & then
        sut.load(request) { (result: Result<Data, NetworkingError>) in
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

