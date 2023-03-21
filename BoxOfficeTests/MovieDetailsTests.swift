//
//  MovieDetailsTests.swift
//  MovieDetailsTests
//
//  Created by Muri, Rowan on 2023/03/21.
//

import XCTest
@testable import BoxOffice

final class MovieDetailsTests: XCTestCase {

    func test_DataManage의_parse호출시_nil이아니다() {
        // given
        guard let dataAsset = NSDataAsset(name: "ThePolicemansLineage") else { return }
        
        // when
        let result = Result { try DataManager.parse(from: dataAsset.data, returnType: MovieDetails.self) }
        
        // then
        XCTAssertNotNil(result)
    }
    
    func test_파싱해온데이터의_MovieDetails와_예상한값이일치한다() {
        // given
        guard let dataAsset = NSDataAsset(name: "ThePolicemansLineage") else { return }
        let expectation = "경관의 피"
        
        // when
        let data = Result { try DataManager.parse(from: dataAsset.data, returnType: MovieDetails.self) }
        
        switch data {
        case .failure(let error):
            print(error)
        case .success(let result):
            // then
            XCTAssertEqual(result?.movieInfoResult.movieInfo.movieName, expectation)
        }
    }
}
