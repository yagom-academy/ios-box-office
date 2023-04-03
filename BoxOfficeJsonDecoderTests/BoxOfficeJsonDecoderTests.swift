//
//  BoxOfficeJsonDecoderTests.swift
//  BoxOfficeJsonDecoderTests
//
//  Created by vetto, brody on 23/03/20.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeJsonDecoderTests: XCTestCase {
    var sut: BoxOfficeJsonDecoder!

    override func setUp() {
        super.setUp()
        sut = BoxOfficeJsonDecoder()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func tests_loadJsonData호출시_json데이터가_BoxOfficeResult로파싱된다() {
        // given
        let assetName = "box_office_sample"
        let expectedBoxOfficeType = "일별 박스오피스"
        let expectedFirstMovieName = "경관의 피"
        
        // when, then
        do {
            let result = try sut.loadJsonData(name: assetName, type: BoxOfficeItem.self)
            XCTAssertEqual(expectedBoxOfficeType, result.boxOfficeResult.boxOfficeType)
            XCTAssertEqual(
                expectedFirstMovieName,
                result.boxOfficeResult.dailyBoxOfficeList[0].movieName
            )
        } catch {
            XCTFail("The loadJsonData was not supposed to throw an Error")
        }
    }
    
    func tests_loadJsonData호출시_파일이름이_잘못되었다면_DataAssetError를_반환한다() {
        // given
        let assetName = "box_office"
        let expectedError = DataAssetError.invalidFileName
        var thrownError: Error?
        
        // when, then
        XCTAssertThrowsError(try sut.loadJsonData(name: assetName, type: BoxOfficeItem.self)) {
            thrownError = $0
        }
        
        XCTAssertEqual(expectedError, thrownError as? DataAssetError)
    }
}
