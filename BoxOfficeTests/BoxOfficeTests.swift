//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by Kobe, yyss99 on 2023/07/25.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    func test_BoxOffice_객체가_성공적으로_파싱될_경우_nil을_반환하지_않는다() {
        // given
        guard let dataAsset = NSDataAsset(name: "box_office_sample") else { return }
        
        // when
        let result = try! JSONDecoder().decode(BoxOffice.self, from: dataAsset.data)
        
        // than
        XCTAssertNotNil(result)
    }
    
    func test_BoxOffice_객체가_성공적으로_파싱될_경우_boxOfficeType의_Value값을_반환한다() {
        // given
        guard let dataAsset = NSDataAsset(name: "box_office_sample") else { return }
        let expection = "일별 박스오피스"
        
        // when
        let boxOffice = try! JSONDecoder().decode(BoxOffice.self, from: dataAsset.data)
        let result = boxOffice.boxOfficeResult.boxOfficeType
        
        // then
        XCTAssertEqual(expection, result)
    }
    
    func test_BoxOffice_객체가_성공적으로_파싱될_경우_dailyBoxOfficeList_0번째_요소인_movieName의_Value값을_반환한다() {
        // given
        guard let dataAsset = NSDataAsset(name: "box_office_sample") else { return }
        let expection = "경관의 피"
        
        // when
        let boxOffice = try! JSONDecoder().decode(BoxOffice.self, from: dataAsset.data)
        let result = boxOffice.boxOfficeResult.dailyBoxOfficeList[0].movieName
        
        // then
        XCTAssertEqual(result, expection)
    }
}
