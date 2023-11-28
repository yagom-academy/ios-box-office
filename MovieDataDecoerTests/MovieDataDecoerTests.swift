//
//  MovieDataDecoerTests.swift
//  MovieDataDecoerTests
//
//  Created by Morgan, Toy on 11/27/23.
//

import XCTest
@testable import BoxOffice

final class MovieDataDecoerTests: XCTestCase {
    private var sut: BoxOffice!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = try MovieDataDecoder.decodeAssetData(assetName: "box_office_sample", decoder: JSONDecoder())
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    private func test_box_office_sample_디코딩후_boxofficeType은_일별_박스오피스를_반환한다() {
        // given
        let result = sut.boxOffice.boxofficeType
        
        // when
        let boxofficeType = "일별 박스오피스"
    
        // then
        XCTAssertEqual(result, boxofficeType)
    }
    
    private func test_box_office_sample_디코딩후_dailyBoxOfficeList의_0번째요소의_movieName가_경관의_피_를반환한다() {
        // given
        let result = sut.boxOffice.dailyBoxOfficeList[0].movieName

        // when
        let movieName = "경관의 피"
        
        // then
        XCTAssertEqual(result, movieName)
    }
}
