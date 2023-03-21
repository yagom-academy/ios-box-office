//
//  DataManagerTests.swift
//  DataManagerTests
//
//  Created by Muri, Rowan on 2023/03/20.
//

import XCTest
@testable import BoxOffice

final class DataManagerTests: XCTestCase {
    var sut: DataManager!
    
    override func setUpWithError() throws {
        sut = DataManager()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_DataManage의_parse호출시_DailyBoxOffice타입_디코딩결과가_nil이아니다() {
        // given
        guard let dataAsset = NSDataAsset(name: "DailyOffice") else { return }
        
        // when
        let result = Result { try sut.parse(from: dataAsset.data, returnType: DailyBoxOffice.self) }
        
        // then
        XCTAssertNotNil(result)
    }
    
    func test_파싱해온DailyBoxOffice데이터의_boxOfficeType과_예상한값이일치한다() {
        // given
        guard let dataAsset = NSDataAsset(name: "DailyOffice") else { return }
        let expectation = "일별 박스오피스"
        
        // when
        let data = Result { try sut.parse(from: dataAsset.data, returnType: DailyBoxOffice.self) }
        
        switch data {
        case .failure(let error):
            print(error)
        case .success(let result):
            // then
            XCTAssertEqual(result?.boxOfficeResult.boxOfficeType, expectation)
        }
    }
    
    func test_DataManage의_parse호출시_MovieDetails타입_디코딩결과가nil이아니다() {
        // given
        guard let dataAsset = NSDataAsset(name: "ThePolicemansLineage") else { return }
        
        // when
        let result = Result { try sut.parse(from: dataAsset.data, returnType: MovieDetails.self) }
        
        // then
        XCTAssertNotNil(result)
    }
    
    func test_파싱해온MovieDetails데이터의_movieName과_예상한값이일치한다() {
        // given
        guard let dataAsset = NSDataAsset(name: "ThePolicemansLineage") else { return }
        let expectation = "경관의 피"
        
        // when
        let data = Result { try sut.parse(from: dataAsset.data, returnType: MovieDetails.self) }
        
        switch data {
        case .failure(let error):
            print(error)
        case .success(let result):
            // then
            XCTAssertEqual(result?.movieInfoResult.movieInfo.movieName, expectation)
        }
    }
}
