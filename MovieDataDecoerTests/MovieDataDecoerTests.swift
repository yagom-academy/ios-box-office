//
//  MovieDataDecoerTests.swift
//  MovieDataDecoerTests
//
//  Created by Morgan, Toy on 11/27/23.
//

import XCTest
@testable import BoxOffice

final class MovieDataDecoerTests: XCTestCase {
    var sut: BoxOfficeData!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = try MovieDataDecoder.decodeAssetData(assetName: "box_office_sample", decoder: JSONDecoder())
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func test_box_office_sample_디코딩후_boxofficeType은_일별_박스오피스를_반환한다() {
        let result = sut.boxOfficeResult.boxofficeType
        
        let boxofficeType = "일별 박스오피스"
    
        XCTAssertEqual(result, boxofficeType)
    }
}
