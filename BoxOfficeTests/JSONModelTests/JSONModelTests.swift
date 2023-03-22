//
//  JSONModelTests.swift
//  JSONModelTests
//
//  Created by Muri, Rowan on 2023/03/22.
//

import XCTest
@testable import BoxOffice

final class JSONModelTests: XCTestCase {
    let jsonDecoder = JSONDecoder()
    
    func test_DailyOffice를_디코드한결과가_nil이아니고_결과의boxOfficeType이_예상값과일치한다() {
        // given
        guard let dataAsset = NSDataAsset(name: "DailyOffice") else { return }
        let expectation = "일별 박스오피스"
        
        // when
        let result = Result { try jsonDecoder.decode(DailyBoxOffice.self, from: dataAsset.data) }
        
        // then
        switch result {
        case .success(let result):
            XCTAssertNotNil(result)
            XCTAssertEqual(result.boxOfficeResult.boxOfficeType, expectation)
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_MovieDetails를_디코드한결과가_nil이아니고_결과의제목이_예상값과일치한다() {
        // given
        guard let dataAsset = NSDataAsset(name: "ThePolicemansLineage") else { return }
        let expectation = "경관의 피"
        
        // when
        let result = Result { try jsonDecoder.decode(MovieDetails.self, from: dataAsset.data) }
        
        // then
        switch result {
        case .success(let result):
            XCTAssertNotNil(result)
            XCTAssertEqual(result.movieInfoResult.movieInfo.movieName, expectation)
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }
}
