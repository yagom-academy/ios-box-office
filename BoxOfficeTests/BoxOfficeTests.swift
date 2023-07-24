//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by minsup, moon on 2023/07/24.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    
    func test_json파일을_BoxOffice타입으로_디코딩_시_올바르게_데이터를_파싱할_수_있다() {
        let decoder = JSONDecoder()
        guard let dataAsset = NSDataAsset(name: "boxOfficeTestSample") else {
            XCTFail("데이터를 Asset에서 불러 올 수 없습니다.")
            return
        }
        
        do {
            let data = try decoder.decode(BoxOffice.self, from: dataAsset.data)
            XCTAssertEqual(data.boxOfficeResult.boxOfficeType, "일별 박스오피스")
            XCTAssertEqual(data.boxOfficeResult.dateRange, "20220105~20220105")
            XCTAssertEqual(data.boxOfficeResult.boxOfficeItems[0].rankNumber, "1")
            XCTAssertEqual(data.boxOfficeResult.boxOfficeItems[0].rank, "1")
            XCTAssertEqual(data.boxOfficeResult.boxOfficeItems[0].amountOfRankChange, "0")
            XCTAssertEqual(data.boxOfficeResult.boxOfficeItems[0].rankOldAndNew, "NEW")
            XCTAssertEqual(data.boxOfficeResult.boxOfficeItems[0].movieCode, "20199882")
            XCTAssertEqual(data.boxOfficeResult.boxOfficeItems[0].movieName, "경관의 피")
            XCTAssertEqual(data.boxOfficeResult.boxOfficeItems[0].openDate, "2022-01-05")
            XCTAssertEqual(data.boxOfficeResult.boxOfficeItems[0].salesAmount, "584559330")
            XCTAssertEqual(data.boxOfficeResult.boxOfficeItems[0].salesShare, "34.2")
            XCTAssertEqual(data.boxOfficeResult.boxOfficeItems[0].amountOfSalesChange, "584559330")
            XCTAssertEqual(data.boxOfficeResult.boxOfficeItems[0].rateOfSalesChange, "100")
            XCTAssertEqual(data.boxOfficeResult.boxOfficeItems[0].accumulatedSales, "631402330")
            XCTAssertEqual(data.boxOfficeResult.boxOfficeItems[0].audienceCount, "64050")
            XCTAssertEqual(data.boxOfficeResult.boxOfficeItems[0].amountOfAudienceCountChange, "64050")
            XCTAssertEqual(data.boxOfficeResult.boxOfficeItems[0].rateOfAudienceCountChange, "100")
            XCTAssertEqual(data.boxOfficeResult.boxOfficeItems[0].accumulatedAudienceCount, "69228")
            XCTAssertEqual(data.boxOfficeResult.boxOfficeItems[0].screenCount, "1171")
            XCTAssertEqual(data.boxOfficeResult.boxOfficeItems[0].showCount, "4416")
        } catch {
            XCTFail("데이터를 BoxOffice 타입으로 디코딩 할 수 없습니다.")
            return
        }
    }
}
