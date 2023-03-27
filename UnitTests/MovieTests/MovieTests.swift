//
//  MovieTests.swift
//  MovieTests
//
//  Created by kaki, harry on 2023/03/21.
//

import XCTest
@testable import BoxOffice

final class MovieTests: XCTestCase {
    private var sut: Movie!
    
    override func setUpWithError() throws {
        let jsonDecoder = JSONDecoder()
        let dataAsset = NSDataAsset(name: "Movie")!
        
        sut = try! jsonDecoder.decode(Movie.self, from: dataAsset.data)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_MoviewInfo의_movieKoreanName은_문자열_광해왕이된남자이다() {
        // given
        let expectedResult = "광해, 왕이 된 남자"
     
        // when
        let movieKoreanName = sut.movieInfoResult.info.koreanName
        
        // then
        XCTAssertEqual(expectedResult, movieKoreanName)
    }
    
    func test_MoviewInfo의_director은_문자열_추창민이다() {
        // given
        let expectedResult = "추창민"
     
        // when
        let directorName = sut.movieInfoResult.info.directors[safe: 0]?.peopleName
        
        // then
        XCTAssertEqual(expectedResult, directorName)
    }
    
    func test_MoviewInfo의_openDateText은_문자열_20120913이다() {
        // given
        let expectedResult = "20120913"
     
        // when
        let openDateText = sut.movieInfoResult.info.openDateText
        
        // then
        XCTAssertEqual(expectedResult, openDateText)
    }
}
