//
//  DailyBoxOfficeTests.swift
//  DailyBoxOfficeTests
//
//  Created by Muri, Rowan on 2023/03/20.
//

import XCTest
@testable import BoxOffice

final class DailyBoxOfficeTests: XCTestCase {
    
    func test_DataManage의_parse호출시_nil이아니다() {
        // given
        guard let dataAsset = NSDataAsset(name: "DailyOffice") else { return }
        
        // when
        let result = Result { try DataManager.parse(from: dataAsset.data, returnType: DailyBoxOffice.self) }
        
        // then
        XCTAssertNotNil(result)
    }
    
    func test_파싱해온데이터의_DailyBoxOffice와_예상한값이일치한다() {
        // given
        guard let dataAsset = NSDataAsset(name: "DailyOffice") else { return }
        let expectation = "일별 박스오피스"
        
        // when
        let data = Result { try DataManager.parse(from: dataAsset.data, returnType: DailyBoxOffice.self) }
        
        switch data {
        case .failure(let error):
            print(error)
        case .success(let result):
            // then
            XCTAssertEqual(result?.boxOfficeResult.boxOfficeType, expectation)
        }
    }
}
