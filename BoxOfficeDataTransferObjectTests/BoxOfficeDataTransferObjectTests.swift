//
//  BoxOfficeDataTransferObjectTests.swift
//  BoxOfficeDataTransferObjectTests
//
//  Created by kyungmin, Erick on 2023/07/24.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeDataTransferObjectTests: XCTestCase {
    func test_BoxOffice_DTO객체가_Parsing에_성공하여_nil을_반환하지_않습니다() {
        //given
        guard let dataAsset = NSDataAsset(name: "box_office_sample") else {
            return
        }
        
        //when
        let result = try? JSONDecoder().decode(BoxOffice.self, from: dataAsset.data)
        
        //then
        XCTAssertNotNil(result)
    }
    
    func test_BoxOffice_DTO객체가_Parsing에_성공하여_boxofficeType이_일별_박스오피스를_반환() {
        //given
        guard let dataAsset = NSDataAsset(name: "box_office_sample") else {
            return
        }
        
        let expectation = "일별 박스오피스"
        
        //when
        let boxOffice = try? JSONDecoder().decode(BoxOffice.self, from: dataAsset.data)
        let result = boxOffice?.boxOfficeResult.boxOfficeType
        
        //then
        XCTAssertEqual(result, expectation)
    }
    
    func test_BoxOffice_DTO객체가_Parsing에_성공하여_dailyBoxOfficeList안에_첫번째_요소의_movieName이_경관의_피를_반환() {
        //given
        guard let dataAsset = NSDataAsset(name: "box_office_sample") else {
            return
        }
        
        let expectation = "경관의 피"
        
        //when
        let boxOffice = try? JSONDecoder().decode(BoxOffice.self, from: dataAsset.data)
        let result = boxOffice?.boxOfficeResult.dailyBoxOfficeList.first?.movieName
        
        //then
        XCTAssertEqual(result, expectation)
    }
}
