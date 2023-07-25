//
//  JsonDecodeTests.swift
//  JsonDecodeTests
//
//  Created by hoon, mint on 2023/07/24.
//

import XCTest
@testable import BoxOffice

extension BoxOfficeItem: Equatable {
    public static func == (lhs: BoxOfficeItem, rhs: BoxOfficeItem) -> Bool {
        return lhs.movieCode == rhs.movieCode
    }
}

final class JsonDecodeTests: XCTestCase {
    var sut: DailyBoxOffice!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let bundle = Bundle(for: JsonDecodeTests.self)
        guard let json = NSDataAsset(name: "box_office_sample", bundle: bundle) else {
            return
        }
        sut = try JSONDecoder().decode(DailyBoxOffice.self, from: json.data)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_boxOfficeSample_디코딩하면_일별박스오피스를_반환한다() {
        //given
        let result = sut.boxOfficeResult.boxOfficeType
        
        //when
        let expectation = "일별 박스오피스"
        
        //then
        XCTAssertEqual(result, expectation)
    }

    func test_boxOfficeSample_디코딩하면_1번_아이템의_rankOldAndNew에서_new를_반환한다() {
        //given
        let result = sut.boxOfficeResult.dailyBoxOfficeList.first?.rankExistence
        
        //when
        let expectation = BoxOfficeItem.RankExistence.new
        
        //then
        XCTAssertEqual(result, expectation)
    }
    
    func test_boxOfficeSample_디코딩하면_daliyBoxOfficeList에서_BoxOfficeItemInformation을_반환한다() throws {
        //given
        let result = sut.boxOfficeResult.dailyBoxOfficeList.first
        let json =
            """
            {"rnum":"1",
            "rank":"1",
            "rankInten":"0",
            "rankOldAndNew":"NEW",
            "movieCd":"20199882",
            "movieNm":"경관의 피",
            "openDt":"2022-01-05",
            "salesAmt":"584559330",
            "salesShare":"34.2",
            "salesInten":"584559330",
            "salesChange":"100",
            "salesAcc":"631402330",
            "audiCnt":"64050",
            "audiInten":"64050",
            "audiChange":"100",
            "audiAcc":"69228",
            "scrnCnt":"1171",
            "showCnt":"4416"}
            """
        
        //when
        guard let jsonData = json.data(using: .utf8) else {
            return
        }
        let expectation = try JSONDecoder().decode(BoxOfficeItem.self, from: jsonData)
        
        //then
        XCTAssertEqual(result, expectation)
    }
}
