//
//  BoxOfficeResultTests.swift
//  BoxOfficeTests
//
//  Created by Serena, BMO on 2023/07/25.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeResultTests: XCTestCase {
    var sut: BoxOfficeResult?
    var assetFileName: String = "box_office_sample"
    
    override func setupWithError() throws {
        try super.setupWithError()
        assetFileName = "box_office_sample"
        
        do {
            let boxOffice: BoxOffice = try JSONDecoder.decode(fileName: assetFileName)
            sut = boxOffice.boxOfficeResult
        } catch JSONDecoderError.notFoundedAssetFileName {
            XCTFail("JSON 파일을 부르는데 실패하였습니다.")
        } catch JSONDecoderError.failureDataDecoding {
            XCTFail("디코딩에 실패하였습니다.")
        } catch {
            XCTFail("알 수 없는 에러가 발생했습니다.")
        }
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_box_office_sample을_Decode하면_BoxOfficeResult_인스턴스가_존재한다() {
        // Given

        // When
        
        // Then
        XCTAssertNotNil(sut)
    }
    
    func test_box_office_sample과_일치하는_파일이_없어_Decode할_수_없다() {
        // Given
        assetFileName = "wrong_file_name"
        
        do {
            // When
            let boxOffice: BoxOffice = try JSONDecoder.decode(fileName: assetFileName)
        } catch let error as JSONDecoderError {
            switch error {
            case .notFoundedAssetFileName:
                // Then
                XCTAssertEqual(error, JSONDecoderError.notFoundedAssetFileName)
            case .failureDataDecoding:
                XCTFail("디코딩에 실패하였습니다.")
            }
        } catch {
            XCTFail("알 수 없는 에러가 발생했습니다.")
        }
    }
    
    func test_box_office_sample를_이용하여_Decode가_실패한다() {
        // Given
        assetFileName = "box_office_sample"
        
        do {
            // When
            let boxOfficeResult: BoxOfficeResult = try JSONDecoder.decode(fileName: assetFileName)
        } catch let error as JSONDecoderError {
            switch error {
            case .notFoundedAssetFileName:
                XCTFail("JSON 파일을 부르는데 실패하였습니다.")
            case .failureDataDecoding:
                // Then
                XCTAssertEqual(error, JSONDecoderError.failureDataDecoding)
            }
        } catch {
            XCTFail("알 수 없는 에러가 발생했습니다.")
        }
    }
    
    func test_boxOfficeType이_일별_박스오피스를_반환한다() {
        // Given
        let result = sut?.boxOfficeType
        
        // When
        let expectedResult: String = "일별 박스오피스"
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_dailyBoxOfficeList의_값이_있다() {
        // Given
        let result = sut?.dailyBoxOfficeList.isEmpty
        
        // When
        let expectedResult = false
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_dailyBoxOfficeList_첫번째_배열의_영화_제목이_경관의_피_이다() {
        // Given
        let result = sut?.dailyBoxOfficeList.first?.movieName
        
        // When
        let expectedResult = "경관의 피"
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_dailyBoxOfficeList_첫번째_배열의_영화_코드가_20199882_이다() {
        // Given
        let result = sut?.dailyBoxOfficeList.first?.movieCode
        
        // When
        let expectedResult = "20199882"
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
}
