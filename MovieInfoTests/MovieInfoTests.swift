//
//  MovieInfoTests.swift
//  MovieInfoTests
//
//  Created by 레옹아범 ,Andrew on 2023/03/20.
//

import XCTest
@testable import BoxOffice

final class MovieInfoTests: XCTestCase {
    
    var sut: DailyBoxofficeObject!

    override func setUpWithError() throws {
        let boxofficeSample = NSDataAsset(name: "box_office_sample")!
        
        sut = try! JSONDecoder().decode(DailyBoxofficeObject.self, from: boxofficeSample.data)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_BoxOfficeResult에서_boxofficeType이_일별_박스오피스값을_가진다() {
        // given
        let boxofficeType = sut.boxOfficeResult.boxofficeType
         
        // when
        let result = "일별 박스오피스"
        
        // then
        XCTAssertEqual(boxofficeType, result)
    }
    
    func test_BoxOfficeResult에서_dataRange가_20220105_20220105값을_가진다() {
        // given
        let duration = sut.boxOfficeResult.dateRange
        
        // when
        let result = "20220105~20220105"
        
        // then
        XCTAssertEqual(duration, result)
    }
    
    func test_BoxOfficeResult에서_movies의_첫번째영화이름은_경관의_피이다() {
        // given
        let movieName = sut.boxOfficeResult.movies[0].name
        
        // when
        let result = "경관의 피"
        
        // then
        XCTAssertEqual(movieName, result)
    }
    
    func test_BoxOfficeResult에서_movies의_첫번째영화의_누적관객수는_69_콤마_228이다() {
        // given
        let totalOfAudience = sut.boxOfficeResult.movies[0].totalOfAudience
        let exception = totalOfAudience.formatDecimal()!
        
        // when
        let result = "69,228"
        
        // then
        XCTAssertEqual(exception, result)
    }

}
