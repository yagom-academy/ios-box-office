//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by EtialMoon, Minsup on 2023/07/24.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    
    let decoder = JSONDecoder()
    let dataAsset: NSDataAsset! = NSDataAsset(name: "boxOfficeTestSample")
    
    func test_JSON데이터를_BoxOffice타입으로_디코딩하면_boxOfficeResult에_데이터가_올바르게_저장되어_있다() throws {
        let typeResult = try decoder.decode(BoxOffice.self, from: dataAsset.data).boxOfficeResult.boxOfficeType
        let typeExpectation = "일별 박스오피스"
        
        let dateResult = try decoder.decode(BoxOffice.self, from: dataAsset.data).boxOfficeResult.dateRange
        let dateExpectation = "20220105~20220105"
        
        XCTAssertEqual(typeResult, typeExpectation)
        XCTAssertEqual(dateResult, dateExpectation)
    }
    
    func test_JSON파일을_BoxOffice타입으로_디코딩하면_boxOfficeItems에_데이터가_올바르게_저장되어_있다() throws {
        let result = try decoder.decode(BoxOffice.self, from: dataAsset.data).boxOfficeResult.boxOfficeItems[0]
        let expectation = BoxOfficeItem(
            rankNumber: "1",
            rank: "1",
            amountOfRankChange: "0",
            rankOldAndNew: "NEW",
            movieCode: "20199882",
            movieName: "경관의 피",
            openDate: "2022-01-05",
            salesAmount: "584559330",
            salesShare: "34.2",
            amountOfSalesChange: "584559330",
            rateOfSalesChange: "100",
            accumulatedSales: "631402330",
            audienceCount: "64050",
            amountOfAudienceCountChange: "64050",
            rateOfAudienceCountChange: "100",
            accumulatedAudienceCount: "69228",
            screenCount: "1171",
            showCount: "4416"
        )
            
        XCTAssertEqual(result, expectation)
    }
}
